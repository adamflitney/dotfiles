-- Lualine statusline configuration
-- Enhanced with opencode.nvim integration
return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Add opencode statusline component to the right side
      table.insert(opts.sections.lualine_z, {
        function()
          return require("opencode").statusline()
        end,
        cond = function()
          -- Only show when opencode is available
          local ok = pcall(require, "opencode")
          return ok
        end,
      })

      -- Add copilot statusline component
      table.insert(opts.sections.lualine_z, {
        function()
          local icon = " "
          local status = require("copilot.api").status.data
          return icon .. (status.status or "")
        end,
        cond = function()
          local ok, clients = pcall(vim.lsp.get_clients, { name = "copilot", bufnr = 0 })
          return ok and #clients > 0
        end,
      })
    end,
  },
}
