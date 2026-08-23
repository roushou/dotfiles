# Git aliases and helpers.

export alias gs = git status --short
export alias gd = git diff
export alias gl = git log --oneline -20
export alias ga = git add
export alias gc = git commit
export alias gp = git push
export alias gpl = git pull
export alias glog = git log --oneline --graph --decorate --all

# Fuzzy git branch checkout (prefers a local branch over origin/…).
export def gco [query?: string] {
  let branches = (^git branch --all --format "%(refname:short)" | lines
    | where {|b| $b != "HEAD" and ($b | str trim) != "" }
    | uniq)

  let choice = ($branches | str join (char newline)
    | ^fzf --height 40% --reverse --query ($query | default "") --header "git checkout"
    | str trim)

  if ($choice | is-empty) { return }

  let local = ($choice | str replace -r '^[^/]+/' '')
  let branch = if ($branches | any {|b| $b == $local }) { $local } else { $choice }

  ^git checkout $branch
}

# Switch back to the previously checked-out branch.
export def gprev [] { ^git switch - }

# cd to the root of the current git repository.
export def --env groot [] {
  let r = (^git rev-parse --show-toplevel | complete)
  if $r.exit_code != 0 {
    error make --unspanned { msg: "not inside a git repository" }
  }
  cd ($r.stdout | str trim)
}

# Browse commit history with fzf; Enter shows the selected commit.
export def glogf [] {
  let pick = (^git log --oneline --color=never
    | ^fzf --height 80% --preview "git show --stat --patch --color=always {1}"
    | split row " " | first)

  if ($pick | is-empty) { return }
  ^git show $pick
}

# Stage files interactively (multi-select with fzf).
export def gadd [] {
  let files = (^git status --porcelain -z
    | split row (char nul)
    | where {|e| not ($e | is-empty) }
    | each {|e| $e | str substring 3.. }
    | ^fzf --multi --height 60% --preview "git diff --color=always -- {}")

  if ($files | is-empty) { return }
  $files | lines | each {|f| ^git add $f }
}

# Delete merged branches (multi-select with fzf; keeps main/master).
export def gclean [] {
  let branches = (^git branch --merged
    | lines
    | each {|b| $b | str trim | str replace '*' '' | str trim }
    | where {|b| $b not-in ["main" "master"] }
    | ^fzf --multi --height 50% --preview "git log --oneline -5 {}")

  if ($branches | is-empty) { return }
  $branches | lines | each {|b| ^git branch -d ($b | str trim) }
}

# Most frequently changed files in the repo.
export def gchurn [n: int = 20] {
  ^git log --pretty=format: --name-only
  | lines
  | where {|l| not ($l | is-empty) }
  | uniq --count
  | sort-by count --reverse
  | first $n
  | rename file changes
}

# All branches as a sortable table (branch, upstream, last commit, subject).
export def gbranches [] {
  ^git for-each-ref --format='%(refname:short)|%(upstream:short)|%(committerdate:relative)|%(subject)' refs/heads
  | lines
  | each {|l| $l | split row "|" }
  | each {|p| { branch: $p.0, upstream: $p.1, last: $p.2, subject: $p.3 } }
}

# Open a pull request for the current branch (pushes it first if needed).
export def gpr [--draft (-d)] {
  let branch = (^git branch --show-current | str trim)
  let up = (^git rev-parse --abbrev-ref --symbolic-full-name "@{u}" | complete)
  if $up.exit_code != 0 {
    ^git push -u origin $branch
  }
  if $draft {
    ^gh pr create --fill --draft
  } else {
    ^gh pr create --fill
  }
}

# Browse stashes with fzf: show, pop, or drop the selected one.
export def gstash [--pop (-p), --drop (-d)] {
  let pick = (^git stash list
    | ^fzf --height 50% --preview "git stash show -p --color=always {1}")

  if ($pick | is-empty) { return }
  let name = ($pick | split row ":" | first)

  if $pop {
    ^git stash pop $name
  } else if $drop {
    ^git stash drop $name
  } else {
    ^git stash show -p $name | ^delta
  }
}
