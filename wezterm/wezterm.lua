local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font = wezterm.font("JetBrains Mono")
config.color_scheme = "Catppuccin Mocha"
config.enable_tab_bar = false
config.default_cursor_style = "SteadyBlock"
config.warn_about_missing_glyphs = false

config.keys = {
	{
		key = "P",
		mods = "CTRL",
		action = wezterm.action.DisableDefaultAssignment,
	},
}

-- Disable ligatures
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

return config
