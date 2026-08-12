require("mini.ai").setup({
	mappings = {
		-- g[/g] are claimed by gitsigns hunk navigation (after/plugin/gitsigns.lua)
		goto_left = "",
		goto_right = "",
	},
})
require("mini.comment").setup()
require("mini.pairs").setup()
require("mini.notify").setup()
require("mini.files").setup()
require("mini.pick").setup()
require("mini.jump2d").setup()
require("mini.bufremove").setup()
require("mini.starter").setup()
require("mini.statusline").setup()
require("mini.surround").setup()
