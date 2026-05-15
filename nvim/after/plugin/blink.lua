require("blink.cmp").setup({
    keymap = { preset = "enter" },
    completion = {
        menu = {
            min_width = 20,
            draw = {
                padding = 1,
                gap = 1,
                treesitter = { "lsp" },
                columns = { { "kind_icon" }, { "label", gap = 1 } },
                components = {
                    label = {
                        text = function(ctx)
                            return require("colorful-menu").blink_components_text(ctx)
                        end,
                        highlight = function(ctx)
                            return require("colorful-menu").blink_components_highlight(ctx)
                        end,
                    },
                },
            },
        },
        documentation = {
            auto_show = true,
            treesitter_highlighting = true,
            window = {
                border = "rounded",
            },
        },
    },
    signature = {
        enabled = true,
        window = { border = "single" },
    },
    appearance = {
        nerd_font_variant = "mono",
    },
    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
})
