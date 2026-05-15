local M = {}

function M.map(mode, keys, func, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, keys, func, options)
end

return M
