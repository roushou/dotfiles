local M = {}

M.config = {
	flavour = "mocha", -- latte, frappe, macchiato, mocha
	background = { -- :h background
		light = "latte",
		dark = "mocha",
	},
	transparent_background = false, -- disables setting the background color.
	show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
	term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
	dim_inactive = {
		enabled = false, -- dims the background color of inactive window
		shade = "dark",
		percentage = 0.15, -- percentage of the shade to apply to the inactive window
	},
	no_italic = true, -- Force no italic
	no_bold = false, -- Force no bold
	no_underline = false, -- Force no underline
	styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
		comments = { "italic" }, -- Change the style of comments
		conditionals = { "italic" },
		loops = {},
		functions = {},
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
		operators = {},
		-- miscs = {}, -- Uncomment to turn off hard-coded styles
	},
	color_overrides = {
		mocha = {
			rosewater = "#F5E0DC",
			flamingo = "#F2CDCD",
			mauve = "#DDB6F2",
			pink = "#F5C2E7",
			red = "#F28FAD",
			maroon = "#E8A2AF",
			peach = "#F8BD96",
			yellow = "#FAE3B0",
			green = "#ABE9B3",
			blue = "#96CDFB",
			sky = "#89DCEB",
			teal = "#B5E8E0",
			lavender = "#C9CBFF",
			text = "#D9E0EE",
			subtext1 = "#BAC2DE",
			subtext0 = "#A6ADC8",
			overlay2 = "#C3BAC6",
			overlay1 = "#988BA2",
			overlay0 = "#6E6C7E",
			surface2 = "#6E6C7E",
			surface1 = "#575268",
			surface0 = "#302D41",
			base = "#1E1E2E",
			mantle = "#1A1826",
			crust = "#161320",
		},
	},
	custom_highlights = {},
	highlight_overrides = {
		mocha = function(mocha)
			return {
				-- For base configs.
				NormalFloat = { fg = mocha.text, bg = false and mocha.none or mocha.base },
				CursorLineNr = { fg = mocha.green },
				Search = { bg = mocha.surface1, fg = mocha.pink, style = { "bold" } },
				IncSearch = { bg = mocha.pink, fg = mocha.surface1 },
				Keyword = { fg = mocha.pink },
				Type = { fg = mocha.blue },
				Typedef = { fg = mocha.yellow },
				StorageClass = { fg = mocha.red },
				-- For native lsp configs.
				DiagnosticVirtualTextError = { bg = mocha.none },
				DiagnosticVirtualTextWarn = { bg = mocha.none },
				DiagnosticVirtualTextInfo = { bg = mocha.none },
				DiagnosticVirtualTextHint = { fg = mocha.rosewater, bg = mocha.none },
				DiagnosticHint = { fg = mocha.rosewater },
				LspDiagnosticsDefaultHint = { fg = mocha.rosewater },
				LspDiagnosticsHint = { fg = mocha.rosewater },
				LspDiagnosticsVirtualTextHint = { fg = mocha.rosewater },
				LspDiagnosticsUnderlineHint = { sp = mocha.rosewater },
				-- For fidget.
				FidgetTask = { bg = mocha.none, fg = mocha.surface2 },
				FidgetTitle = { fg = mocha.blue, style = { "bold" } },
				-- For trouble.nvim
				TroubleNormal = { bg = mocha.base },
				-- For treesitter.
				["@field"] = { fg = mocha.rosewater },
				["@property"] = { fg = mocha.yellow },
				["@include"] = { fg = mocha.teal },
				-- ["@operator"] = { fg = cp.sky },
				["@keyword.operator"] = { fg = mocha.sky },
				["@punctuation.special"] = { fg = mocha.maroon },
				-- ["@float"] = { fg = cp.peach },
				-- ["@number"] = { fg = cp.peach },
				-- ["@boolean"] = { fg = cp.peach },

				["@constructor"] = { fg = mocha.lavender },
				-- ["@constant"] = { fg = cp.peach },
				-- ["@conditional"] = { fg = cp.mauve },
				-- ["@repeat"] = { fg = cp.mauve },
				["@exception"] = { fg = mocha.peach },
				["@constant.builtin"] = { fg = mocha.lavender },
				-- ["@function.builtin"] = { fg = cp.peach, style = { "italic" } },
				-- ["@type.builtin"] = { fg = cp.yellow, style = { "italic" } },
				["@type.qualifier"] = { link = "@keyword" },
				-- ["@variable.builtin"] = { fg = cp.red, style = { "italic" } },
				["@variable.builtin"] = { fg = mocha.red },
				-- ["@function"] = { fg = cp.blue },
				["@function.macro"] = { fg = mocha.red, style = {} },
				["@parameter"] = { fg = mocha.rosewater },
				["@keyword"] = { fg = mocha.red },
				["@keyword.function"] = { fg = mocha.maroon },
				["@keyword.return"] = { fg = mocha.pink, style = {} },
				-- ["@text.note"] = { fg = cp.base, bg = cp.blue },
				-- ["@text.warning"] = { fg = cp.base, bg = cp.yellow },
				-- ["@text.danger"] = { fg = cp.base, bg = cp.red },
				-- ["@constant.macro"] = { fg = cp.mauve },

				-- ["@label"] = { fg = cp.blue },
				-- ["@method"] = { fg = cp.blue, style = { "italic" } },
				["@method"] = { fg = mocha.blue, style = {} },
				["@namespace"] = { fg = mocha.rosewater, style = {} },
				["@punctuation.delimiter"] = { fg = mocha.teal },
				["@punctuation.bracket"] = { fg = mocha.overlay2 },
				-- ["@string"] = { fg = cp.green },
				-- ["@string.regex"] = { fg = cp.peach },
				["@type"] = { fg = mocha.yellow },
				["@variable"] = { fg = mocha.text },
				["@tag.attribute"] = { fg = mocha.mauve, style = {} },
				["@tag"] = { fg = mocha.peach },
				["@tag.delimiter"] = { fg = mocha.maroon },
				["@text"] = { fg = mocha.text },
				-- ["@text.uri"] = { fg = cp.rosewater, style = { "italic", "underline" } },
				-- ["@text.literal"] = { fg = cp.teal, style = { "italic" } },
				-- ["@text.reference"] = { fg = cp.lavender, style = { "bold" } },
				-- ["@text.title"] = { fg = cp.blue, style = { "bold" } },
				-- ["@text.emphasis"] = { fg = cp.maroon, style = { "italic" } },
				-- ["@text.strong"] = { fg = cp.maroon, style = { "bold" } },
				-- ["@string.escape"] = { fg = cp.pink },

				-- ["@property.toml"] = { fg = cp.blue },
				-- ["@field.yaml"] = { fg = cp.blue },

				-- ["@label.json"] = { fg = cp.blue },

				["@function.builtin.bash"] = { fg = mocha.red, style = {} },
				["@parameter.bash"] = { fg = mocha.yellow, style = {} },
				["@field.lua"] = { fg = mocha.lavender },
				["@constructor.lua"] = { fg = mocha.flamingo },
				["@variable.builtin.lua"] = { fg = mocha.flamingo, style = {} },
				["@constant.java"] = { fg = mocha.teal },
				["@property.typescript"] = { fg = mocha.lavender, style = {} },
				-- ["@constructor.typescript"] = { fg = cp.lavender },

				-- ["@constructor.tsx"] = { fg = cp.lavender },
				["@tag.attribute.tsx"] = { fg = mocha.mauve, style = {} },

				["@type.css"] = { fg = mocha.lavender },
				["@property.css"] = { fg = mocha.yellow },
				["@type.builtin.c"] = { fg = mocha.yellow, style = {} },
				["@property.cpp"] = { fg = mocha.text },
				["@type.builtin.cpp"] = { fg = mocha.yellow, style = {} },
				-- ["@symbol"] = { fg = cp.flamingo },
			}
		end,
	},
	default_integrations = true,
	integrations = {
		cmp = true,
		gitsigns = true,
		-- nvimtree = true,
		neotree = true,
		treesitter = true,
		notify = false,
		mini = {
			enabled = true,
			indentscope_color = "",
		},
		-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
	},
}

return M
