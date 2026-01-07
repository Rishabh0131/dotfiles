local gitsigns = require("gitsigns")

gitsigns.setup({
    signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
    },

    current_line_blame = true,
    current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",

    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local map = function(mode, lhs, rhs, opts)
            opts = opts or { noremap = true, silent = true, buffer = bufnr }
            vim.keymap.set(mode, lhs, rhs, opts)
        end

        -- NVChad-safe hunk navigation
        map("n", "]h", gs.next_hunk)
        map("n", "[h", gs.prev_hunk)

        -- Git actions under <leader>g
        map("n", "<leader>gs", gs.stage_hunk)
        map("n", "<leader>gr", gs.reset_hunk)
        map("v", "<leader>gs", function()
            gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)
        map("v", "<leader>gr", function()
            gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)

        map("n", "<leader>gS", gs.stage_buffer)
        map("n", "<leader>gu", gs.undo_stage_hunk)
        map("n", "<leader>gR", gs.reset_buffer)
        map("n", "<leader>gp", gs.preview_hunk)
        map("n", "<leader>gb", function()
            gs.blame_line({ full = true })
        end)
        map("n", "<leader>gd", gs.diffthis)
        map("n", "<leader>gD", function()
            gs.diffthis("~")
        end)
        map("n", "<leader>gt", gs.toggle_deleted)
    end,
})
