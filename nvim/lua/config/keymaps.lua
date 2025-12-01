-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Universal escape with jk (works in insert mode and terminal mode)
vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true, desc = "Exit insert mode" })
vim.keymap.set("i", "<C-Enter>", "<Esc><CR>", { noremap = true, silent = true })

-- Better window splits
vim.keymap.set("n", "<leader>|", "<cmd>vsplit<cr>", { desc = "Split vertical" })
vim.keymap.set("n", "<leader>-", "<cmd>split<cr>", { desc = "Split horizontal" })
