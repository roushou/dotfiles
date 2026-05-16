local M = {}

-- Parsers to ensure are always installed.
-- Call `:TSUpdate` to update them, `:TSInstall {lang}` to add new ones.
M.ensure_installed = { "lua", "vimdoc", "rust", "go", "python" }

-- Filetypes for which treesitter highlighting + indentation will be enabled.
-- These should match parser names (e.g. vimdoc → help filetype).
M.filetypes = { "lua", "help", "rust", "go", "python", "svelte", "typescript" }

-- Configuration for nvim-treesitter-textobjects.
M.textobjects = {
	select = {
		lookahead = true,
	},
	move = {
		set_jumps = true,
	},
}

return M
