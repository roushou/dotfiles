vim.g.mapleader = " "

local opt = vim.opt

opt.hidden = true
opt.number = true
opt.relativenumber = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.smartindent = true
opt.scrolloff = 8
opt.signcolumn = "yes" -- Always show the sign column
opt.splitright = true
opt.splitbelow = true
-- preview substitutions live
opt.inccommand = "split"

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})
