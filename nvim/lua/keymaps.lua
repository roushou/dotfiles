local map = function(mode, keys, func, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, keys, func, options)
end

local toggle_diffview = function(cmd)
	if next(require("diffview.lib").views) == nil then
		vim.cmd(cmd)
	else
		vim.cmd("DiffviewClose")
	end
end

-- local toggle_diffview = function()
-- 	if next(require("diffview.lib").views) == nil then
-- 		vim.cmd("DiffviewOpen")
-- 	else
-- 		vim.cmd("DiffviewClose")
-- 	end
-- end

-- Insert
map("i", "jj", "<esc>")
map("i", "jk", "<esc>")

-- Normal
map("n", "j", "gj")
map("n", "k", "gk")
map("n", "<leader>w", ":w<cr>")
map("n", "<leader>q", ":q<cr>")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-n>", "<cmd>Neotree toggle<cr>")
map("n", "<C-p>", "<cmd>Pick files<cr>")
map("n", "<leader>fw", "<cmd>Pick grep_live<cr>")
map("n", "H", "<cmd>BufferLineCyclePrev<cr>")
map("n", "L", "<cmd>BufferLineCycleNext<cr>")
map("n", "<leader>x", "<cmd>lua MiniBufremove.delete()<cr>")
-- Trouble
vim.keymap.set("n", "<leader>tt", function()
	require("trouble").toggle()
end)
vim.keymap.set("n", "<leader>tw", function()
	require("trouble").toggle("workspace_diagnostics")
end)
vim.keymap.set("n", "<leader>td", function()
	require("trouble").toggle("document_diagnostics")
end)
vim.keymap.set("n", "<leader>tq", function()
	require("trouble").toggle("quickfix")
end)
vim.keymap.set("n", "<leader>tl", function()
	require("trouble").toggle("loclist")
end)
vim.keymap.set("n", "gd", function()
	require("trouble").toggle("lsp_definitions")
end)
vim.keymap.set("n", "gi", function()
	require("trouble").toggle("lsp_implementations")
end)
vim.keymap.set("n", "gr", function()
	require("trouble").toggle("lsp_references")
end)
-- GitSigns
map("n", "g[", "<cmd>Git prev_hunk<cr>")
map("n", "g]", "<cmd>Git next_hunk<cr>")
-- Diffview
map("n", "<leader>gv", toggle_diffview)

-- Visual
map("v", "<", "<gv")
map("v", ">", ">gv")
