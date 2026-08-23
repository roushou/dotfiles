# Fuzzy file navigation (fzf + fd + git).

# Fuzzy-find a file and open it in $EDITOR.
export def fuzzy_open [--depth: int, --hidden] {
  let r = (^git rev-parse --show-toplevel | complete)
  let in_repo = ($r.exit_code == 0)
  let root = if $in_repo { $r.stdout | str trim } else { $env.PWD }

  let sprawling = [
    "/" "/tmp" "/Users" "/home" "/opt" "/var"
    $env.HOME
    ($env.HOME | path join "Downloads")
    ($env.HOME | path join "Documents")
    ($env.HOME | path join "Library")
  ]
  let max_depth = if $depth != null { $depth } else if ($root in $sprawling) { 2 } else { 8 }

  let files = if $in_repo {
    ^git -C $root ls-files --cached --others --exclude-standard | lines
  } else if $hidden {
    ^fd --type f --max-depth $max_depth --hidden --exclude .git | lines
  } else {
    ^fd --type f --max-depth $max_depth | lines
  }

  if ($files | is-empty) {
    print $"No files under ($root)"
    return
  }

  let choice = (
    $files
    | str join (char newline)
    | ^fzf --height "70%" --reverse --border --info inline --header $root
    | str trim
  )

  if ($choice | is-empty) { return }

  let ed = ($env.EDITOR? | default $env.VISUAL? | default "vi" | split row " ")
  ^($ed | first) ...($ed | skip 1) ($root | path join $choice)
}

# Project directories under ~/dev (Tab-completes `fuzzy_work`).
def dev-projects [] {
  ls --short-names ($env.HOME | path join "dev")
  | where type == dir
  | get name
  | sort
}

# Fuzzy-jump into a project under ~/dev.
export def --env fuzzy_work [query?: string@dev-projects] {
  let base = ($env.HOME | path join "dev")

  if not ($base | path exists) {
    error make --unspanned { msg: $"($base) does not exist" }
  }

  let dirs = (ls --short-names $base | where type == dir | get name | sort)

  let candidates = if $query == null {
    $dirs
  } else {
    $dirs | where ($it | str lowercase) =~ ($query | str lowercase)
  }

  match ($candidates | length) {
    0 => { print "No matching directories."; return }
    1 => { cd ($base | path join ($candidates | first)); return }
    _ => {}
  }

  let choice = ($candidates | input list --fuzzy $"($candidates | length) projects")
  if ($choice | is-empty) { return }

  cd ($base | path join $choice)
}
