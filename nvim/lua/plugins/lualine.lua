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
    end,
  },
}
