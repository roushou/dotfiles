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

-- Treesitter must be set up BEFORE the colorscheme so that catppuccin's
-- treesitter integration can properly link highlight groups.
local treesitter_config = require("plugins.treesitter")
require("nvim-treesitter").setup(treesitter_config)

local catppuccin = require("plugins.catppuccin")
require("catppuccin").setup(catppuccin.config)
vim.cmd.colorscheme("catppuccin")
