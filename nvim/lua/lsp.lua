local map = require("util").map

-- Global LSP handler overrides (set once, not per-attach)
vim.lsp.handlers["textDocument/hover"] = function(_, result, ctx, config)
    config = vim.tbl_deep_extend("force", config or {}, { border = "single", title = "hover" })
    vim.lsp.handlers.hover(_, result, ctx, config)
end
vim.lsp.handlers["textDocument/signatureHelp"] = function(_, result, ctx, config)
    config = vim.tbl_deep_extend("force", config or {}, { border = "single" })
    vim.lsp.handlers.signature_help(_, result, ctx, config)
end

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        client.server_capabilities.semanticTokensProvider = nil

        if client.server_capabilities.hoverProvider then
            map("n", "K", vim.lsp.buf.hover, { buffer = args.buf })
        end

        map("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end)
        map("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end)
        map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>")
        if vim.bo[args.buf].filetype == "rust" then
            map("n", "<leader>ca", function() vim.cmd.RustLsp("codeAction") end, { buffer = args.buf })
        else
            map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", { buffer = args.buf })
        end
    end,
})

local function blink_capabilities()
    return require("blink.cmp").get_lsp_capabilities()
end

vim.lsp.config("lua_ls", {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
    capabilities = blink_capabilities(),
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            completion = { callSnippet = "Replace" },
            telemetry = { enable = false },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
        },
    },
})
vim.lsp.enable("lua_ls")

vim.lsp.config("gopls", {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_markers = { "go.mod", ".git" },
    capabilities = blink_capabilities(),
})
vim.lsp.enable("gopls")

vim.lsp.config("basedpyright", {
    cmd = { "basedpyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = { "pyrightconfig.json", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" },
    capabilities = blink_capabilities(),
    settings = {
        basedpyright = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly",
            },
        },
    },
})
vim.lsp.enable("basedpyright")

vim.lsp.config("ruff", {
    cmd = { "ruff", "server" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
    capabilities = blink_capabilities(),
    init_options = {
        settings = {},
    },
})
vim.lsp.enable("ruff")

vim.lsp.config("ts_ls", {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
    capabilities = blink_capabilities(),
})
vim.lsp.enable("ts_ls")

vim.lsp.config("tailwindcss", {
    cmd = { "@tailwindcss/language-server", "--stdio" },
    filetypes = {
        "html", "css", "scss", "javascript", "javascriptreact",
        "typescript", "typescriptreact", "svelte", "vue", "astro",
        "markdown", "mdx", "heex", "elixir", "php", "erb", "templ",
    },
    root_markers = { "tailwind.config.js", "tailwind.config.ts", "tailwind.config.mjs", "tailwind.config.cjs", ".git" },
    capabilities = blink_capabilities(),
})
vim.lsp.enable("tailwindcss")

vim.lsp.config("zls", {
    cmd = { "zls" },
    filetypes = { "zig", "zir" },
    root_markers = { "zls.json", "build.zig", ".git" },
    capabilities = blink_capabilities(),
})
vim.lsp.enable("zls")

vim.lsp.config("protols", {
    cmd = { "protols" },
    filetypes = { "proto" },
    root_markers = { ".git" },
    capabilities = blink_capabilities(),
})
vim.lsp.enable("protols")

vim.lsp.config("wgsl_analyzer", {
    cmd = { "wgsl-analyzer" },
    filetypes = { "wgsl" },
    root_markers = { ".git" },
    capabilities = blink_capabilities(),
})
vim.lsp.enable("wgsl_analyzer")

vim.lsp.config("astro", {
    cmd = { "astro-ls", "--stdio" },
    filetypes = { "astro" },
    root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
    capabilities = blink_capabilities(),
})
vim.lsp.enable("astro")

vim.lsp.config("svelte", {
    cmd = { "svelteserver", "--stdio" },
    filetypes = { "svelte" },
    root_markers = { "package.json", ".git" },
    capabilities = blink_capabilities(),
})
vim.lsp.enable("svelte")

vim.lsp.config("jsonls", {
    cmd = { "vscode-json-languageserver", "--stdio" },
    filetypes = { "json", "jsonc" },
    root_markers = { ".git" },
    capabilities = blink_capabilities(),
})
vim.lsp.enable("jsonls")

vim.lsp.config("cssls", {
    cmd = { "vscode-css-languageserver", "--stdio" },
    filetypes = { "css", "scss", "less" },
    root_markers = { "package.json", ".git" },
    capabilities = blink_capabilities(),
})
vim.lsp.enable("cssls")

vim.lsp.config("tombi", {
    cmd = { "tombi", "lsp" },
    filetypes = { "toml" },
    root_markers = { "tombi.toml", "pyproject.toml", ".git" },
    capabilities = blink_capabilities(),
})
vim.lsp.enable("tombi")

vim.lsp.config("luau_lsp", {
    cmd = { "luau-lsp", "lsp" },
    filetypes = { "luau" },
})
vim.lsp.enable("luau_lsp")

vim.lsp.config("clangd", {
    cmd = { "clangd" },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
    root_markers = { ".clangd", ".clang-tidy", ".clang-format", "compile_commands.json", "compile_flags.txt", "configure.ac", ".git" },
    capabilities = blink_capabilities(),
})
vim.lsp.enable("clangd")
