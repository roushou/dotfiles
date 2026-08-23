# Disk-usage helpers, layered on the built-in `du` (try `help du`).

# Compact human-readable size with binary units, like `du -h` (K/M/G/T).
export def "size human" [bytes: filesize] {
  let b = ($bytes | into int | into float)
  if $b >= 1099511627776 {
    $"($b / 1099511627776 | math round -p 1)T"
  } else if $b >= 1073741824 {
    $"($b / 1073741824 | math round -p 1)G"
  } else if $b >= 1048576 {
    $"($b / 1048576 | math round -p 1)M"
  } else if $b >= 1024 {
    $"($b / 1024 | math round -p 1)K"
  } else {
    $"($b | math round)B"
  }
}

# Flatten a `du --long` tree into flat records. (implementation detail)
def "du flat" [nodes: list, depth: int, want_dirs: bool, want_files: bool] {
  $nodes | each {|n|
    let child_dirs = (du flat ($n.directories? | default []) ($depth + 1) $want_dirs $want_files)
    let self = (if $want_dirs { [{ path: $n.path, type: "dir", depth: $depth, apparent: $n.apparent, physical: $n.physical }] } else { [] })
    let files = (if $want_files { ($n.files? | default []) | each {|f| { path: $f.path, type: "file", depth: ($depth + 1), apparent: $f.apparent, physical: $f.physical } } } else { [] })
    $self ++ $files ++ $child_dirs
  } | flatten
}

# Biggest things in a tree, ranked by real (recursive) disk usage.
export def biggest [
  path: path = "."             # where to scan
  n: int = 20                  # how many results to show
  --recursive (-r)             # rank entries anywhere in the tree (default: dirs only)
  --files-only (-f)            # only files
  --dirs-only (-D)             # only directories
  --physical (-p)              # rank by on-disk (physical) size instead of apparent
  --all (-a)                   # include hidden entries
  --min-size (-m): int         # skip entries smaller than this many bytes
  --ignore: list<string> = []  # extra file/dir names to skip (matches any path component)
] {
  let ignored = [
    ".git"
    ".svn"
    ".hg"

    "target"
    "node_modules"
    "vendor"

    "dist"
    "build"
    "out"
    ".output"
    ".next"
    ".nuxt"

    "__pycache__"
    ".pytest_cache"
    ".mypy_cache"
    ".ruff_cache"

    ".cache"
    "coverage"
  ] | append $ignore | uniq

  let root = ($path | path expand)
  if not ($root | path exists) {
    error make --unspanned { msg: $"($root) does not exist" }
  }

  let tree = (du --long $root)

  # Top level shows both kinds; recursive defaults to dirs (files are noisy
  # and slow to rank globally — pass --files-only if you really want them).
  let want_dirs = (not $files_only)
  let want_files = ($files_only or (not ($dirs_only or $recursive)))

  let rows = if $recursive {
    (du flat $tree 0 $want_dirs $want_files) | where {|r| $r.depth > 0 }
  } else {
    let dirs = (if $want_dirs { $tree.0.directories? | default [] | each {|n| { path: $n.path, type: "dir", apparent: $n.apparent, physical: $n.physical } } } else { [] })
    let files = (if $want_files { $tree.0.files? | default [] | each {|n| { path: $n.path, type: "file", apparent: $n.apparent, physical: $n.physical } } } else { [] })
    $dirs ++ $files
  }

  let size_col = (if $physical { "physical" } else { "apparent" })
  let min = if $min_size == null { null } else { ($min_size | into filesize) }

  $rows
    | where {|r| ($r.path | path relative-to $root | path split | all {|p| $p not-in $ignored }) }
    | where {|r| if $all { true } else { $r.path | path relative-to $root | path split | all {|p| not ($p | str starts-with ".") } } }
    | each {|r| { name: ($r.path | path relative-to $root), type: $r.type, size: ($r | get $size_col) } }
    | where {|r| $min == null or ($r.size >= $min) }
    | sort-by size --reverse
    | first $n
}

# Interactive disk-usage explorer (ncdu/gdu style): Enter descends, the ".."
# entry goes up, Esc/Ctrl-C quits.
export def dui [path: path = "."] {
  let root = ($path | path expand)
  mut cur = $root

  loop {
    let c = $cur
    let tree = (du --long $c)
    let dirs = ($tree.0.directories? | default [] | each {|n| { name: ($n.path | path relative-to $c), type: "dir", size: $n.apparent } })
    let files = ($tree.0.files? | default [] | each {|n| { name: ($n.path | path relative-to $c), type: "file", size: $n.apparent } })
    let entries = ($dirs ++ $files | sort-by size --reverse)

    let lines = ($entries | each {|e|
      $"(size human $e.size | fill -a r -w 9)\t($e.type | fill -a r -w 4)\t($e.name)"
    })
    let options = (if $c == $root { $lines } else { [".."] | append $lines })

    let total = (size human $tree.0.apparent)
    let header = $"($c)  ·  ($total) total  ·  ($entries | length) entries"
    let choice = ($options | str join (char newline)
      | ^fzf --header $header --reverse --height 70% --info inline --no-sort
      | str trim)

    if ($choice | is-empty) { return }
    if $choice == ".." { $cur = ($c | path dirname); continue }

    let name = ($choice | split row (char tab) | last)
    let p = ($c | path join $name)

    if ($p | path type) == "dir" {
      $cur = $p
    } else {
      let d = (du $p | first)
      print $"(ansi cyan)($p)(ansi reset)  apparent (size human $d.apparent)  ·  physical (size human $d.physical)"
    }
  }
}
