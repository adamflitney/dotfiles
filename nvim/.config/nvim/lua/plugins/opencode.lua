-- OpenCode AI assistant integration
-- Provides editor-aware AI assistance with context support
-- https://github.com/NickvanDyke/opencode.nvim
return {
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
    },
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        -- Use snacks.nvim as the provider for terminal integration
        provider = {
          enabled = "snacks",
          snacks = {
            -- Snacks terminal configuration
            win = {
              position = "right",
              size = 0.4,
            },
          },
        },
        -- Enable autoread for real-time buffer reloading when opencode edits files
        events = {
          reload = true,
        },
      }

      -- Required for opts.events.reload
      vim.o.autoread = true

      -- Register which-key group
      local wk = require("which-key")
      wk.add({
        { "<leader>o", group = "opencode" },
      })

      -- Keymaps using <leader>o prefix
      -- Ask opencode with context
      vim.keymap.set({ "n", "x" }, "<leader>oa", function()
        require("opencode").ask("@this: ", { submit = true })
      end, { desc = "Ask opencode" })

      -- Select from all opencode functionality
      vim.keymap.set({ "n", "x" }, "<leader>os", function()
        require("opencode").select()
      end, { desc = "Select action" })

      -- Toggle opencode terminal
      vim.keymap.set({ "n", "t" }, "<leader>ot", function()
        require("opencode").toggle()
      end, { desc = "Toggle terminal" })

      -- Operator for adding ranges to opencode
      vim.keymap.set({ "n", "x" }, "<leader>oo", function()
        return require("opencode").operator("@this ")
      end, { expr = true, desc = "Add range" })

      -- Add current line to opencode
      vim.keymap.set("n", "<leader>ol", function()
        return require("opencode").operator("@this ") .. "_"
      end, { expr = true, desc = "Add line" })

      -- Quick prompt actions
      vim.keymap.set({ "n", "x" }, "<leader>or", function()
        require("opencode").prompt("review")
      end, { desc = "Review code" })

      vim.keymap.set({ "n", "x" }, "<leader>of", function()
        require("opencode").prompt("fix")
      end, { desc = "Fix diagnostics" })

      vim.keymap.set({ "n", "x" }, "<leader>oe", function()
        require("opencode").prompt("explain")
      end, { desc = "Explain code" })

      vim.keymap.set({ "n", "x" }, "<leader>om", function()
        require("opencode").prompt("document")
      end, { desc = "Document code" })

      vim.keymap.set({ "n", "x" }, "<leader>oi", function()
        require("opencode").prompt("implement")
      end, { desc = "Implement code" })

      vim.keymap.set({ "n", "x" }, "<leader>op", function()
        require("opencode").prompt("optimize")
      end, { desc = "Optimize code" })

      -- Scroll through opencode messages
      vim.keymap.set("n", "<leader>ou", function()
        require("opencode").command("session.half.page.up")
      end, { desc = "Scroll up" })

      vim.keymap.set("n", "<leader>od", function()
        require("opencode").command("session.half.page.down")
      end, { desc = "Scroll down" })

      -- Session management
      vim.keymap.set("n", "<leader>on", function()
        require("opencode").command("session.new")
      end, { desc = "New session" })

      vim.keymap.set("n", "<leader>oc", function()
        require("opencode").command("session.compact")
      end, { desc = "Compact session" })

      vim.keymap.set("n", "<leader>ox", function()
        require("opencode").command("session.interrupt")
      end, { desc = "Interrupt" })
    end,
  },
}
