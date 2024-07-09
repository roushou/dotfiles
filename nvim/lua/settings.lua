vim.g.mapleader = " "

local opt = vim.opt

opt.hidden = true
opt.number = true
opt.relativenumber = true
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.smartindent = true
opt.scrolloff = 8
opt.signcolumn = "yes" -- Always show the sign column
opt.splitright = true
opt.splitbelow = true
-- preview substitutions live
opt.inccommand = "split"
opt.wrap = true
opt.linebreak = true

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "go",
	callback = function()
		require("go.format").goimports()
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "rust",
	callback = function()
		vim.lsp.inlay_hint.enable()
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "go",
	callback = function()
		vim.opt_local.shiftwidth = 4
		vim.opt_local.tabstop = 4
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "solidity",
	callback = function()
		vim.opt_local.shiftwidth = 4
		vim.opt_local.tabstop = 4
	end,
})
