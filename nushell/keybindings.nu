# Keybindings — sourced from config.nu.
# Custom keybindings are additive (`++=`), so these don't clobber defaults.

$env.config.keybindings ++= [
  {
    name: accept_autosuggestion
    modifier: control
    keycode: char_f
    mode: [emacs, vi_insert, vi_normal]
    event: { send: historyhintcomplete }
  }
  {
    name: fuzzy_open
    modifier: control
    keycode: char_p
    mode: [emacs, vi_insert, vi_normal]
    event: { send: executehostcommand, cmd: "fuzzy_open" }
  }
  {
    name: fuzzy_work
    modifier: control
    keycode: char_o
    mode: [emacs, vi_insert, vi_normal]
    event: { send: executehostcommand, cmd: "fuzzy_work" }
  }
]
