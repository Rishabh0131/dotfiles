local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require("nvchad.configs.lspconfig") -- nvim 0.11
local lspconfig_util = require("lspconfig.util")
-- list of all servers configured.
lspconfig.servers = {
    "lua_ls",
    "angularls",
    "pyright",
    "gopls",
}

-- list of servers configured with default config.
local default_servers = {
    "pyright",
    "angularls",
}

-- lsps with default config
for _, lsp in ipairs(default_servers) do
    vim.lsp.config(lsp, { -- nvim 0.11
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
    })
end

-- Lua LSP config
vim.lsp.config("lua_ls", { -- nvim 0.11
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,

    settings = {
        Lua = {
            diagnostics = {
                enable = false, -- Disable all diagnostics from lua_ls
                -- globals = { "vim" },
            },
            workspace = {
                library = {
                    vim.fn.expand("$VIMRUNTIME/lua"),
                    vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
                    vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types",
                    vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
                    "${3rd}/love2d/library",
                },
                maxPreload = 100000,
                preloadFileSize = 10000,
            },
        },
    },
})

-- Python LSP config
vim.lsp.config("pyright", { -- nvim 0.11
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,

    settings = {
        python = {
            analysis = {
                typeCheckingMode = "off", -- Enable/Disable type checking diagnostics
            },
        },
    },
})

-- Angular LSP config
vim.lsp.config("angularls", {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,

    filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx" },

    -- Automatically detect the Angular project root
    root_dir = lspconfig_util.root_pattern("angular.json", "package.json"),

    -- Dynamically use the project's node_modules
    on_new_config = function(new_config, new_root_dir)
        local node_modules = new_root_dir .. "/node_modules"

        new_config.cmd = {
            "node",
            vim.fn.stdpath("data")
                .. "/mason/packages/angular-language-server/node_modules/@angular/language-server/index.js",
            "--ngProbeLocations",
            node_modules,
            "--tsProbeLocations",
            node_modules,
            "--stdio",
        }
    end,
})

-- Go LSP config
vim.lsp.config("gopls", {
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        on_attach(client, bufnr)
    end,
    on_init = on_init,
    capabilities = capabilities,
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gotmpl", "gowork" },
    -- root_dir = lspconfig_util.root_pattern("go.work", "go.mod", ".git"),
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            completeUnimported = true,
            usePlaceholders = true,
            staticcheck = true,
        },
    },
})
-- read :h vim.lsp.config for changing options of lsp servers
