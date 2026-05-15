require("gitsigns").setup({})

vim.keymap.set("n", "g[", "<cmd>Git prev_hunk<cr>")
vim.keymap.set("n", "g]", "<cmd>Git next_hunk<cr>")
vim.keymap.set("n", "<leader>gp", "<cmd>Git preview_hunk_inline<cr>")
vim.keymap.set("n", "<leader>gd", "<cmd>Git diffthis<cr>")
