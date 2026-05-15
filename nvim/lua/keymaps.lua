local map = require("util").map

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

-- Visual
map("v", "<", "<gv")
map("v", ">", ">gv")
map("v", "<leader>y", '"+y')
map("v", "<leader>p", '"+p')
