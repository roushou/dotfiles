require("lazy").setup({
	{
		'catppuccin/nvim',
		name = 'catppuccin',
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme catppuccin-mocha]])
		end,
	},
	{
		'echasnovski/mini.nvim',
		version = '*',
		config = function()
			require('mini.comment').setup()
			require('mini.pairs').setup()
			require('mini.notify').setup()
			require('mini.pick').setup()
			require('mini.bufremove').setup()
			require('mini.starter').setup()
			require('mini.statusline').setup()
			require('mini.surround').setup()
		end,
	},
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			{ 'williamboman/mason.nvim', config = true , opts = { ui= { border = 'single' } }}, -- NOTE: Must be loaded before dependants
			'williamboman/mason-lspconfig.nvim',
			'WhoIsSethDaniel/mason-tool-installer.nvim',
		},
		config = function()
			require('lsp')
		end,
	},
	{
		'mrcjkb/rustaceanvim',
		version = '^4', -- Recommended
		lazy = false, -- This plugin is already lazy
	},
	{ 'folke/neodev.nvim', opts = {} },
	{
		'hrsh7th/nvim-cmp',
		event ="InsertEnter",
		dependencies = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
		},
		config = function()
			require('completion')
		end,
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},
	{ 'nvim-treesitter/nvim-treesitter' },
	{
		'akinsho/bufferline.nvim',
		version = '*',
		dependencies = 'nvim-tree/nvim-web-devicons',
		opts = {
			options = {
				show_buffer_close_icons = false,
				hover = {
					enable = true,
					reveal = { 'close' },
				},
			},
		},
	},
	{
		'nvim-neo-tree/neo-tree.nvim',
		branch = "v3.x",
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-tree/nvim-web-devicons',
			'MunifTanjim/nui.nvim',
		},
		opts = {
			close_if_last_window = false,
			window = {
				position = 'right',
				width = 30,
			},
			filesystem = {
				follow_current_file = {
					enabled = true,
					leave_dirs_open = true,
				},
			},
		},
	},
	{
		"kdheepak/lazygit.nvim",
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
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
		}
	},
	{ 'lewis6991/gitsigns.nvim', opts = {} },
	{
		'windwp/nvim-ts-autotag',
		event ="BufReadPre",
		opts = {
			opts = {
				enable_close = true,
				enable_rename = true,
				enable_close_on_slash = true,
			},
		},
	},
}, {
	ui = {
		border = 'single',
	},
})