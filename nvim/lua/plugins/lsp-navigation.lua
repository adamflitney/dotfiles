-- Enhanced LSP navigation with Telescope integration
-- Extends LazyVim defaults without overriding
return {
  -- Enhanced LSP keybindings
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      
      -- Add custom LSP keybindings that extend defaults
      vim.list_extend(keys, {
        -- Telescope-based navigation (better than default quickfix)
        {
          "gr",
          "<cmd>Telescope lsp_references<cr>",
          desc = "References (Telescope)",
          has = "references",
        },
        {
          "<leader>ls",
          "<cmd>Telescope lsp_document_symbols<cr>",
          desc = "Document symbols",
        },
        {
          "<leader>lS",
          "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
          desc = "Workspace symbols",
        },
        {
          "<leader>lr",
          "<cmd>Telescope lsp_references<cr>",
          desc = "LSP references",
        },
        {
          "<leader>li",
          "<cmd>Telescope lsp_incoming_calls<cr>",
          desc = "Incoming calls",
        },
        {
          "<leader>lo",
          "<cmd>Telescope lsp_outgoing_calls<cr>",
          desc = "Outgoing calls",
        },
      })
    end,
  },
  -- Configure inlay hints for TypeScript
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = true,
      },
      servers = {
        tsserver = {
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },
      },
    },
  },
}
