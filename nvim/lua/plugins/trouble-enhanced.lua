-- Enhanced Trouble configuration with neotest integration
-- Extends LazyVim's default Trouble config
return {
  "folke/trouble.nvim",
  opts = function(_, opts)
    -- Extend default opts, don't replace
    opts = opts or {}
    
    -- Add neotest source for test results
    opts.modes = opts.modes or {}
    opts.modes.test = {
      mode = "diagnostics",
      filter = {
        any = {
          buf = 0,
          {
            severity = vim.diagnostic.severity.ERROR,
            function(item)
              return item.source == "neotest"
            end,
          },
        },
      },
    }
    
    return opts
  end,
  keys = {
    -- Keep LazyVim defaults and add test-specific binding
    {
      "<leader>xt",
      "<cmd>Trouble test<cr>",
      desc = "Test results (Trouble)",
    },
  },
}
