-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Tab navigation (NvChad style)
vim.keymap.set("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Previous Buffer" })

-- jj → Escape (insert mode)
vim.keymap.set("i", "jj", "<Esc>", { desc = "Escape insert mode" })

-- Alt + / to toggle comment (same as gcc)
vim.keymap.set("n", "<M-/>", "gcc", { remap = true, desc = "Toggle comment line" })
vim.keymap.set("v", "<M-/>", "gc", { remap = true, desc = "Toggle comment selection" })

-- Delete current buffer (short key)
vim.keymap.set("n", "<A-x>", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })
