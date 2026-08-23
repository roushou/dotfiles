# config.nu
#
# Installed by:
# version = "0.114.1"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings, 
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R

$env.EDITOR = "nvim"
$env.VISUAL = "nvim"
$env.PAGER = "less -R"

$env.config.show_banner = false
$env.config.buffer_editor = "nvim"
$env.config.edit_mode = "vi"
$env.config.table.mode = "single"
$env.config.history.file_format = "sqlite"


use std/util "path add"

# ─── PATH ───────────────────────────────────────────────────────────────────
# Prepends, highest precedence last-added. Only add what your login shell missed.
path add "~/.local/bin"
path add "~/.cargo/bin"
path add "~/go/bin"
path add "/usr/local/go/bin"
path add "~/.bun/bin"
path add "/opt/homebrew/bin"

# ─── Modules ────────────────────────────────────────────────────────────────
# Custom commands & aliases live in ./modules/*.nu.
# `use … *` imports every exported name into the global scope (no namespace),
# so commands keep their existing names: biggest, gco, fuzzy_open, …
use modules/git.nu *
use modules/disk.nu *
use modules/history.nu *
use modules/files.nu *
use modules/util.nu *

# Custom keybindings (Ctrl-F accept, Ctrl-P fuzzy open, Ctrl-O fuzzy work)
source keybindings.nu

# https://starship.rs/guide/
# Regenerate the prompt hook only when the generated file is missing or stale
# (starship config or binary newer than it) — saves a subprocess + file write
# on every launch otherwise.
mkdir ($nu.data-dir | path join "vendor/autoload")
let starship_nu = ($nu.data-dir | path join "vendor/autoload/starship.nu")
let starship_conf = ($env.STARSHIP_CONFIG? | default ($env.HOME | path join ".config/starship.toml"))
let starship_bin = (which starship | get --optional path.0)
let starship_stale = ($starship_nu | path exists) and (($starship_conf | path exists) and ((ls $starship_conf | get modified.0) > (ls $starship_nu | get modified.0)) or ($starship_bin != null and ((ls $starship_bin | get modified.0) > (ls $starship_nu | get modified.0))))
if ($starship_bin != null) and (not ($starship_nu | path exists) or $starship_stale) {
  starship init nu | save -f $starship_nu
}
# starship removed after install? drop the stale autoload file so it isn't sourced
# (its prompt closures call the absolute binary path and would error on every prompt).
if ($starship_bin == null) and ($starship_nu | path exists) { rm $starship_nu }
