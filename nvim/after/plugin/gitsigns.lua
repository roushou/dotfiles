require("gitsigns").setup({})

vim.keymap.set("n", "g[", require("gitsigns").prev_hunk, { desc = "Gitsigns: prev hunk" })
vim.keymap.set("n", "g]", require("gitsigns").next_hunk, { desc = "Gitsigns: next hunk" })
vim.keymap.set("n", "<leader>gp", require("gitsigns").preview_hunk_inline, { desc = "Gitsigns: preview hunk inline" })
vim.keymap.set("n", "<leader>gd", require("gitsigns").diffthis, { desc = "Gitsigns: diff this" })
