require("go").setup()

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		require("go.format").goimports()
	end,
	group = vim.api.nvim_create_augroup("GoFormat", {}),
})
