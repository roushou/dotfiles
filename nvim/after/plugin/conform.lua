require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        rust = { "rustfmt" },
    },
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.lua", "*.rs" },
    callback = function(args)
        require("conform").format({ bufnr = args.buf })
    end,
})
