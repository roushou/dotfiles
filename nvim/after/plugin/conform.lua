require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		rust = { "rustfmt" },
		odin = { "odinfmt" },
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.lua", "*.rs", "*.odin" },
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})
