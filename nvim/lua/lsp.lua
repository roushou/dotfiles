vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		client.server_capabilities.semanticTokensProvider = nil

		vim.lsp.handlers["textDocument/hover"] =
			vim.lsp.with(vim.lsp.handlers.hover, { border = "single", title = "hover" })
		vim.lsp.handlers["textDocument/signatureHelp"] =
			vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })

		local map = function(mode, keys, func, opts)
			local options = { noremap = true, silent = true }
			if opts then
				options = vim.tbl_extend("force", options, opts)
			end
			vim.keymap.set(mode, keys, func, options)
		end

		if client.server_capabilities.hoverProvider then
			map("n", "K", vim.lsp.buf.hover, { buffer = args.buf })
		end

		vim.diagnostic.config({
			float = { border = "single" },
		})

		map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
		map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")
		map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>")
		map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>")
	end,
})

vim.lsp.enable("gopls")

vim.lsp.enable("basedpyright")

vim.lsp.config("ruff", {
	init_options = {
		settings = {},
	},
})

vim.lsp.enable("ts_ls")
vim.lsp.enable("tailwindcss")
vim.lsp.enable("sourcekit")
vim.lsp.enable("zls")
vim.lsp.enable("protols")
vim.lsp.enable("wgsl_analyzer")
vim.lsp.enable("astro")
vim.lsp.enable("svelte")
vim.lsp.enable("jsonls")
vim.lsp.enable("cssls")
vim.lsp.enable("tombi")

require("mason").setup()
