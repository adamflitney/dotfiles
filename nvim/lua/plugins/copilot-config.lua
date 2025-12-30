-- GitHub Copilot configuration with custom Tab behavior
-- Integrates Copilot ghost text with nvim-cmp completion menu
-- Priority: snippets → copilot → cmp menu → indent
return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")

      -- Override Tab to handle: snippets → copilot → cmp menu → indent
      opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
        -- 1. Jump to next snippet placeholder (highest priority)
        if vim.snippet.active({ direction = 1 }) then
          vim.schedule(function()
            vim.snippet.jump(1)
          end)
          return
        end

        -- 2. Accept Copilot ghost text suggestion if visible
        if require("copilot.suggestion").is_visible() then
          require("copilot.suggestion").accept()
          return
        end

        -- 3. Navigate cmp completion menu if open
        if cmp.visible() then
          cmp.select_next_item()
          return
        end

        -- 4. Default behavior (indent)
        fallback()
      end, { "i", "s" })

      -- Add Shift-Tab for reverse navigation
      opts.mapping["<S-Tab>"] = cmp.mapping(function(fallback)
        -- Jump to previous snippet placeholder
        if vim.snippet.active({ direction = -1 }) then
          vim.schedule(function()
            vim.snippet.jump(-1)
          end)
          return
        end

        -- Navigate cmp menu backward
        if cmp.visible() then
          cmp.select_prev_item()
          return
        end

        fallback()
      end, { "i", "s" })
    end,
  },
}
