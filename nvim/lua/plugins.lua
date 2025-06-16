require("lazy").setup({
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			local catppuccin = require("plugins.catppuccin")
			require("catppuccin").setup(catppuccin.config)
			vim.cmd([[colorscheme catppuccin]])
		end,
	},
	{
		"echasnovski/mini.nvim",
		version = "*",
		config = function()
			require("mini.ai").setup()
			require("mini.comment").setup()
			require("mini.pairs").setup()
			require("mini.notify").setup()
			require("mini.files").setup()
			require("mini.pick").setup()
			require("mini.jump2d").setup()
			require("mini.bufremove").setup()
			require("mini.starter").setup()
			require("mini.statusline").setup()
			require("mini.surround").setup()
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", config = true, opts = { ui = { border = "single" } } }, -- NOTE: Must be loaded before dependants
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"saghen/blink.cmp",
		},
		opts = {
			servers = {
				zls = {},
				ts_ls = {},
				gopls = {},
				pylsp = {},
				tailwindcss = {},
				sourcekit = {},
				lua_ls = {
					settings = {
						Lua = {
							runtime = {
								version = "LuaJIT",
							},
							diagnostics = {
								globals = { "vim" },
							},
							completion = {
								callSnippet = "Replace",
							},
							telemetry = {
								enable = false,
							},
						},
					},
				},
			},
		},
		config = function(_, opts)
			require("lsp")

			local lspconfig = require("lspconfig")
			for server, config in pairs(opts.servers) do
				config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
				lspconfig[server].setup(config)
			end
		end,
	},
	{
		"saghen/blink.cmp",
		dependencies = "rafamadriz/friendly-snippets",
		version = "*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- 'default' for mappings similar to built-in completion
			-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
			-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
			-- See the full "keymap" documentation for information on defining your own keymap.
			keymap = { preset = "enter" },
			completion = {
				menu = {
					auto_show = function(ctx)
						return ctx.mode ~= "cmdline"
					end,
					-- border = "padded",
				},
				documentation = {
					treesitter_highlighting = true,
					window = {
						border = "single",
					},
				},
			},
			signature = {
				enabled = true,
				window = { border = "single" },
			},
			appearance = {
				-- Sets the fallback highlight groups to nvim-cmp's highlight groups
				-- Useful for when your theme doesn't support blink.cmp
				-- Will be removed in a future release
				use_nvim_cmp_as_default = true,
				-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				nerd_font_variant = "mono",
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
		},
		opts_extend = { "sources.default" },
	},
	{
		"bassamsdata/namu.nvim",
		config = function()
			require("namu").setup({
				-- Enable the modules you want
				namu_symbols = {
					enable = true,
					options = {
						display = {
							format = "tree_guides",
						},
					},
				},
				-- Optional: Enable other modules if needed
				ui_select = { enable = false }, -- vim.ui.select() wrapper
			})
			-- === Suggested Keymaps: ===
			vim.keymap.set("n", "<leader>ss", ":Namu symbols<cr>", {
				desc = "Jump to LSP symbol",
				silent = true,
			})
			vim.keymap.set("n", "<leader>sw", ":Namu workspace<cr>", {
				desc = "LSP Symbols - Workspace",
				silent = true,
			})
		end,
	},
	{
		"xzbdmw/colorful-menu.nvim",
		dependencies = {
			"saghen/blink.cmp",
			"onsails/lspkind.nvim",
		},
		config = function()
			require("blink.cmp").setup({
				completion = {
					menu = {
						draw = {
							treesitter = { "lsp" },
							-- We don't need label_description now because label and label_description are already
							-- combined together in label by colorful-menu.nvim.
							columns = { { "kind_icon" }, { "label", gap = 1 } },
							components = {
								label = {
									text = function(ctx)
										return require("colorful-menu").blink_components_text(ctx)
									end,
									highlight = function(ctx)
										return require("colorful-menu").blink_components_highlight(ctx)
									end,
								},
							},
						},
					},
				},
			})
		end,
	},
	{
		"wojciech-kulik/xcodebuild.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"MunifTanjim/nui.nvim",
			"folke/snacks.nvim", -- (optional) to show previews
			"wojciech-kulik/xcodebuild-nvim-preview",
		},
		config = function()
			require("xcodebuild").setup({
				-- put some options here or leave it empty to use default settings
			})
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^5", -- Recommended
		lazy = false, -- This plugin is already lazy
		config = function()
			vim.g.rustaceanvim = {
				server = {
					settings = {
						["rust-analyzer"] = {
							cargo = {
								allFeatures = false,
							},
							checkOnSave = {
								enable = true,
								command = "clippy",
							},
						},
					},
				},
				tools = {
					float_win_config = {
						border = "rounded",
					},
				},
			}
		end,
	},
	{
		"ray-x/go.nvim",
		dependencies = {
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("go").setup()
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()',
	},
	{ "folke/neodev.nvim", opts = {} },
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			local config = require("plugins.treesitter")
			require("nvim-treesitter.configs").setup(config)
		end,
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			options = {
				show_buffer_close_icons = false,
				hover = {
					enable = true,
					reveal = { "close" },
				},
			},
		},
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		opts = {
			close_if_last_window = true,
			window = {
				position = "right",
				width = 30,
			},
			filesystem = {
				filtered_items = {
					always_show = {
						".gitignore",
						".env",
						".dev.vars",
						".github",
					},
				},
				follow_current_file = {
					enabled = true,
					leave_dirs_open = true,
				},
			},
		},
	},
	{
		"sindrets/diffview.nvim",
		cmd = "DiffviewOpen",
		config = function()
			local actions = require("diffview.actions")

			require("diffview").setup({
				keymaps = {
					view = {
						{ "n", "q", actions.close, { desc = "Close menu" } },
					},
					file_panel = {
						{ "n", "q", actions.close, { desc = "Close menu" } },
					},
					file_history_panel = {
						{ "n", "q", actions.close, { desc = "Close menu" } },
					},
				},
			})
		end,
	},
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {},
	},
	{
		"windwp/nvim-ts-autotag",
		event = "BufReadPre",
		opts = {
			opts = {
				enable_close = true,
				enable_rename = true,
				enable_close_on_slash = true,
			},
		},
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				rust = { "rustfmt" },
			},
		},
	},
	{ "nvim-pack/nvim-spectre" },
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			indent = {
				char = "▏",
			},
		},
	},
	{
		"keith/swift.vim",
		config = function() end,
	},
}, {
	ui = {
		border = "single",
	},
})
