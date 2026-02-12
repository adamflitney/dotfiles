-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Universal escape with jk (works in insert mode and terminal mode)
vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true, desc = "Exit insert mode" })
vim.keymap.set("i", "<C-Enter>", "<Esc><CR>", { noremap = true, silent = true })

-- Better window splits
vim.keymap.set("n", "<leader>|", "<cmd>vsplit<cr>", { desc = "Split vertical" })
vim.keymap.set("n", "<leader>-", "<cmd>split<cr>", { desc = "Split horizontal" })

-- Copilot keybindings (complements OpenCode's <leader>o)
vim.keymap.set("n", "<leader>cp", function()
  require("copilot.suggestion").toggle_auto_trigger()
end, { desc = "Toggle Copilot" })

vim.keymap.set("i", "<M-]>", function()
  require("copilot.suggestion").next()
end, { desc = "Next Copilot suggestion" })

vim.keymap.set("i", "<M-[>", function()
  require("copilot.suggestion").prev()
end, { desc = "Previous Copilot suggestion" })

vim.keymap.set("i", "<C-]>", function()
  require("copilot.suggestion").dismiss()
end, { desc = "Dismiss Copilot suggestion" })
