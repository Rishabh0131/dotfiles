local options = {

    formatters_by_ft = {
        lua = { "stylua" },
        html = { "prettierd" },
        css = { "prettierd" },
        json = { "fixjson" },
        python = { "black" },
        go = { "gofumpt", "goimports-reviser" },
        gomod = { "gofumpt", "goimports-reviser" },
        -- html = { "prettier" },
    },

    formatters = {

        -- go
        ["goimports-reviser"] = {
            -- prepend_args = { "-rm-unused" },
        },
        golines = {
            prepend_args = { "--max-len=80", "--shorten-comments", "--base-formatter=gofumpt" },
        },

        -- python
        black = {
            prepend_args = {
                "--fast",
                "--line-length",
                "80",
            },
        },
    },

    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_fallback = true,
    },
}

return options
