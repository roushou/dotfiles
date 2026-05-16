require("settings")
require("keymaps")

local gh = function(repo)
    return "https://github.com/" .. repo
end

vim.pack.add({
    -- Colorscheme
    { src = gh("catppuccin/nvim"),                name = "catppuccin" },

    -- Mini plugins
    { src = gh("echasnovski/mini.nvim"),          name = "mini.nvim",        version = vim.version.range("*") },

    -- LSP
    { src = gh("chrisgrieser/nvim-lsp-endhints"), name = "nvim-lsp-endhints" },

    -- Completion
    {
        src = gh("saghen/blink.cmp"),
        name = "blink.cmp",
        version = vim.version.range("1"),
    },
    { src = gh("rafamadriz/friendly-snippets"), name = "friendly-snippets" },
    { src = gh("xzbdmw/colorful-menu.nvim"),    name = "colorful-menu.nvim" },

    -- Symbols / navigation
    { src = gh("bassamsdata/namu.nvim"),        name = "namu.nvim" },

    -- Rust
    {
        src = gh("mrcjkb/rustaceanvim"),
        name = "rustaceanvim",
        version = vim.version.range("6"),
    },

    -- Diagnostics
    { src = gh("folke/trouble.nvim"),                          name = "trouble.nvim" },
    { src = gh("nvim-tree/nvim-web-devicons"),                 name = "nvim-web-devicons" },

    -- Treesitter
    { src = gh("nvim-treesitter/nvim-treesitter"),             name = "nvim-treesitter" },
    { src = gh("nvim-treesitter/nvim-treesitter-textobjects"), name = "nvim-treesitter-textobjects" },
    { src = gh("nvim-treesitter/nvim-treesitter-context"),     name = "nvim-treesitter-context" },

    -- UI
    { src = gh("akinsho/bufferline.nvim"),                     name = "bufferline.nvim" },
    {
        src = gh("nvim-neo-tree/neo-tree.nvim"),
        name = "neo-tree.nvim",
        version = "v3.x",
    },
    { src = gh("nvim-lua/plenary.nvim"),               name = "plenary.nvim" },
    { src = gh("MunifTanjim/nui.nvim"),                name = "nui.nvim" },

    -- Git
    { src = gh("lewis6991/gitsigns.nvim"),             name = "gitsigns.nvim" },
    { src = gh("sindrets/diffview.nvim"),              name = "diffview.nvim" },
    { src = gh("kdheepak/lazygit.nvim"),               name = "lazygit.nvim" },

    -- Autotag
    { src = gh("windwp/nvim-ts-autotag"),              name = "nvim-ts-autotag" },

    -- Formatting
    { src = gh("stevearc/conform.nvim"),               name = "conform.nvim" },

    -- Search & replace
    { src = gh("nvim-pack/nvim-spectre"),              name = "nvim-spectre" },

    -- Indent guides
    { src = gh("lukas-reineke/indent-blankline.nvim"), name = "indent-blankline.nvim" },

    -- Swift
    { src = gh("keith/swift.vim"),                     name = "swift.vim" },

    -- Go
    { src = gh("ray-x/go.nvim"),                       name = "go.nvim" },
    { src = gh("ray-x/guihua.lua"),                    name = "guihua.lua" },
})

require("lsp")

-- Treesitter
local ts = require("plugins.treesitter")
require("nvim-treesitter").setup({})
require("nvim-treesitter").install(ts.ensure_installed)

-- Enable treesitter highlighting + indentation per filetype
vim.api.nvim_create_autocmd("FileType", {
    pattern = ts.filetypes,
    callback = function()
        vim.treesitter.start()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})

-- Textobjects
local textobjects = require("nvim-treesitter-textobjects")
textobjects.setup(ts.textobjects)

-- Select keymaps
local select_mod = require("nvim-treesitter-textobjects.select")
vim.keymap.set({ "x", "o" }, "af", function()
    select_mod.select_textobject("@function.outer")
end)
vim.keymap.set({ "x", "o" }, "if", function()
    select_mod.select_textobject("@function.inner")
end)
vim.keymap.set({ "x", "o" }, "ac", function()
    select_mod.select_textobject("@class.outer")
end)

-- Move keymaps
local move_mod = require("nvim-treesitter-textobjects.move")
vim.keymap.set({ "n", "x", "o" }, "]m", function()
    move_mod.goto_next_start("@function.outer")
end)
vim.keymap.set({ "n", "x", "o" }, "]o", function()
    move_mod.goto_next_start({ "@loop.inner", "@loop.outer" })
end)
vim.keymap.set({ "n", "x", "o" }, "]s", function()
    move_mod.goto_next_start("@local.scope", "locals")
end)
vim.keymap.set({ "n", "x", "o" }, "]z", function()
    move_mod.goto_next_start("@fold", "folds")
end)

-- Colorscheme (must come after treesitter setup for highlight group linking)
local catppuccin = require("plugins.catppuccin")
require("catppuccin").setup(catppuccin.config)
vim.cmd.colorscheme("catppuccin")
