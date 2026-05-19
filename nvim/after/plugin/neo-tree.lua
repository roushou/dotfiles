require("neo-tree").setup({
    close_if_last_window = true,
    -- Disable console notifications (vim.notify) from Neo-tree.
    -- Only show ERROR and above; suppress INFO and WARN.
    log_level = "error",
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
