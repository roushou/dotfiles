local wezterm = require("wezterm")
local mux = wezterm.mux
local config = wezterm.config_builder()

wezterm.on("gui-startup", function(cmd)
	local _, _, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

config.font = wezterm.font("JetBrains Mono")
config.font_size = 18.0
config.color_scheme = "Catppuccin Mocha"
config.enable_tab_bar = false
config.default_cursor_style = "SteadyBlock"
config.warn_about_missing_glyphs = false
config.window_decorations = "RESIZE"

config.keys = {
	{
		key = "P",
		mods = "CTRL",
		action = wezterm.action.DisableDefaultAssignment,
	},
	{
		key = "t",
		mods = "CMD",
		action = wezterm.action.DisableDefaultAssignment,
	},
}

-- Disable ligatures
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

return config
