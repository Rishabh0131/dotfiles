local options = {
    ensure_installed = {
        "bash",
        "angular",
        "css",
        "go",
        "gomod",
        "gosum",
        "gowork",
        "html",
        "json",
        "python",
        "sql",
        "typescript",
        "lua",
        "luadoc",
        "markdown",
        "printf",
        "toml",
        "vim",
        "vimdoc",
        "yaml",
    },

    highlight = {
        enable = true,
        use_languagetree = true,
    },

    indent = { enable = true },
}

require("nvim-treesitter.configs").setup(options)
