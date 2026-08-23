# Misc shortcuts, shell meta, and small dev tools.

export alias ll = ls -la
export alias lg = lazygit
export alias ag = ast-grep

# Create a new directory and cd into it.
export def --env mk [dir: path] {
  mkdir $dir
  cd $dir
}

# Restart the shell with the current config (run after editing config.nu).
export def reload [] { exec nu }

# Listening TCP ports (Tab-completes `killport`).
def listening-ports [] {
  ^lsof -iTCP -sTCP:LISTEN -P -n
  | lines
  | skip 1
  | parse -r 'TCP .*:(\d+) \(LISTEN\)'
  | get capture0
  | uniq
  | sort
  | into int
}

# Kill whatever is listening on a TCP port.
export def killport [port: int@listening-ports] {
  let pids = (^lsof -ti $"tcp:($port)" -sTCP:LISTEN | lines | str trim | where {|p| $p != "" })

  if ($pids | is-empty) {
    print $"Nothing is listening on port ($port)"
    return
  }

  print $"Killing ($pids | str join ', ') on port ($port)"
  $pids | each {|pid| ^kill -9 $pid }
}

# Known command categories (module names), for `--category` completion.
def categories [] {
  scope modules
  | where name != "prelude" and file != unknown
  | get name
  | sort
}

# List custom commands. Category comes from the defining module file
# (git.nu -> "git") unless a command declares `@category` explicitly.
# Filter: `custom_commands git`, `custom_commands --category git`, or combine.
export def custom_commands [
  search?: string                 # filter by substring in name, description, or category
  --category (-c): string@categories  # filter by exact category (git, disk, history, files, util, ...)
  --sort (-s): string = "name"    # sort by: name, description, category
  --reverse (-r)                  # reverse the sort order
] {
  # decl_id -> category, derived from the module each command was defined in.
  let cat_map = (
    scope modules
    | where file != unknown
    | each {|m| $m.commands | each {|c| {decl_id: $c.decl_id, category: ($m.file | path parse | get stem)}} }
    | flatten
    | reduce -f {} {|row, acc| $acc | insert ($row.decl_id | into string) $row.category }
  )

  let result = (
    scope commands
    | where type == custom
    | upsert description { |row| $row.description? | default "" }
    | upsert category { |row| if ($row.category | is-empty) { $cat_map | get --optional ($row.decl_id | into string) | default "default" } else { $row.category } }
    | select name category description
    | where {|row| $category == null or $row.category == $category}
    | where {|row| $search == null or ($row.name | str contains $search) or ($row.description | str contains $search) or ($row.category | str contains $search)}
  )

  let result = (match $sort {
    "description" => ($result | sort-by description)
    "category" => ($result | sort-by category name)
    _ => ($result | sort-by name)
  })

  let result = if $reverse { $result | reverse } else { $result }

  print $"(ansi cyan_bold)📦 Custom Commands(ansi reset)  •  (ansi green_bold)($result | length)(ansi reset) found"
  $result
}
