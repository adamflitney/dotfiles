-- Snacks.nvim - UI components and utilities
-- Required by opencode.nvim for input, picker, and terminal
return {
  {
    "folke/snacks.nvim",
    opts = {
      -- Input component for opencode prompts
      input = {
        enabled = true,
      },
      -- Picker component for opencode action selection
      picker = {
        enabled = true,
      },
      -- Terminal component for opencode integration
      terminal = {
        enabled = true,
      },
    },
  },
}
