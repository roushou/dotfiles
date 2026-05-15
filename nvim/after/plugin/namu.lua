require("namu").setup({
    namu_symbols = {
        enable = true,
        options = {
            display = {
                mode = "icon",
                format = "tree_guides",
            },
        },
    },
    ui_select = { enable = false },
})

vim.keymap.set("n", "<leader>ss", ":Namu symbols<cr>", {
    desc = "Jump to LSP symbol",
    silent = true,
})
vim.keymap.set("n", "<Bslash>", ":Namu workspace<cr>", {
    desc = "LSP Symbols - Workspace",
    silent = true,
})
