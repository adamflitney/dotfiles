-- TypeScript-specific enhancements
-- Manual import organization, better completions, and compiler diagnostics
return {
  -- TypeScript compiler diagnostics
  {
    "dmmulroy/tsc.nvim",
    cmd = "TSC",
    opts = {
      auto_open_qflist = true,
      enable_progress_notifications = true,
      flags = {
        noEmit = true,
        project = function()
          return vim.fn.getcwd() .. "/tsconfig.json"
        end,
      },
    },
    keys = {
      {
        "<leader>tc",
        "<cmd>TSC<cr>",
        desc = "TypeScript compiler check",
      },
    },
  },
  -- Enhanced TypeScript LSP configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tsserver = {
          keys = {
            -- Manual import management (not automatic)
            {
              "<leader>co",
              function()
                vim.lsp.buf.code_action({
                  apply = true,
                  context = {
                    only = { "source.organizeImports" },
                    diagnostics = {},
                  },
                })
              end,
              desc = "Organize imports",
            },
            {
              "<leader>cM",
              function()
                vim.lsp.buf.code_action({
                  apply = true,
                  context = {
                    only = { "source.addMissingImports.ts" },
                    diagnostics = {},
                  },
                })
              end,
              desc = "Add missing imports",
            },
            {
              "<leader>cR",
              function()
                vim.lsp.buf.code_action({
                  apply = true,
                  context = {
                    only = { "source.removeUnused.ts" },
                    diagnostics = {},
                  },
                })
              end,
              desc = "Remove unused imports",
            },
            {
              "<leader>cu",
              function()
                vim.lsp.buf.code_action({
                  apply = true,
                  context = {
                    only = { "source.removeUnusedImports.ts" },
                    diagnostics = {},
                  },
                })
              end,
              desc = "Remove unused variables",
            },
            {
              "<leader>cD",
              function()
                vim.lsp.buf.code_action({
                  apply = true,
                  context = {
                    only = { "source.fixAll.ts" },
                    diagnostics = {},
                  },
                })
              end,
              desc = "Fix all",
            },
          },
          settings = {
            typescript = {
              format = {
                indentSize = vim.o.shiftwidth,
                convertTabsToSpaces = vim.o.expandtab,
                tabSize = vim.o.tabstop,
              },
              preferences = {
                importModuleSpecifierPreference = "relative",
                quotePreference = "single",
              },
            },
            javascript = {
              format = {
                indentSize = vim.o.shiftwidth,
                convertTabsToSpaces = vim.o.expandtab,
                tabSize = vim.o.tabstop,
              },
              preferences = {
                importModuleSpecifierPreference = "relative",
                quotePreference = "single",
              },
            },
          },
        },
      },
    },
  },
}
