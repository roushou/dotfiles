vim.g.rustaceanvim = {
	server = {
		default_settings = {
			["rust-analyzer"] = {
				cargo = {
					allFeatures = false,
				},
				checkOnSave = {
					enable = true,
					command = "clippy",
				},
			},
		},
	},
	tools = {
		float_win_config = {
			border = "rounded",
		},
	},
}
