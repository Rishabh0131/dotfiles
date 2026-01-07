require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jj", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Move line up/down (Ctrl + Shift + Arrow)
map("n", "<C-S-Up>", ":m .-2<CR>==", { desc = "Move line up" })
map("n", "<C-S-Down>", ":m .+1<CR>==", { desc = "Move line down" })

map("v", "<C-S-Up>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
map("v", "<C-S-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
