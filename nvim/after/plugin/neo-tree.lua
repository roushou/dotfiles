require("neo-tree").setup({
	close_if_last_window = true,
	window = {
		position = "right",
		width = 30,
	},
	filesystem = {
		filtered_items = {
			always_show = {
				".gitignore",
				".env",
				".dev.vars",
				".github",
			},
		},
		follow_current_file = {
			enabled = true,
			leave_dirs_open = true,
		},
	},
})
