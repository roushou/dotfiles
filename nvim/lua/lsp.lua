vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		client.server_capabilities.semanticTokensProvider = nil

		vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single', title = 'hover' })
		vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'single' })

		local map = function(mode, keys, func, opts)
			local options = { noremap = true, silent = true }
			if opts then
				options = vim.tbl_extend('force', options, opts)
			end
			vim.keymap.set(mode, keys, func, options)
		end

		if client.server_capabilities.hoverProvider then
			vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = args.buf })
		end

		vim.diagnostic.config({
			float = { border = 'single' },
		})

		map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
		map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
		map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>')
	end,
})

-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
require("neodev").setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

local servers = {
	lua_ls = {
		settings = {
			Lua = {
				runtime = {
					version = 'LuaJIT',
				},
				diagnostics = {
					globals = { 'vim' },
				},
				completion = {
					callSnippet = 'Replace',
				},
				telemetry = {
					enable = false,
				},
			},
		},
	},
	tsserver = {},
	solc = {},
}

require('mason').setup()

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
	'stylua',
})

require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

require('mason-lspconfig').setup({
	handlers = {
		function(server_name)
			local server = servers[server_name] or {}
			server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
			require('lspconfig')[server_name].setup(server)
		end,
	},
})
