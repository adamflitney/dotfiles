-- Avante.nvim - AI-powered code editing with inline diffs
-- Uses Copilot for fast inline suggestions and OpenCode (via ACP) for intelligent chat/questions
-- 
-- Integration Notes:
--   - Copilot: Uses your existing subscription via copilot.lua for inline suggestions
--   - OpenCode: Integrates via ACP for chat/questions with code editing capabilities
--   - Works alongside opencode.nvim plugin (<leader>o* keybinds) for terminal-based interactions
--   - Avante provides inline diff editing in buffers, opencode.nvim provides terminal chat
--
-- https://github.com/yetone/avante.nvim
return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set to "*"
    -- Build from source or use prebuilt binary
    build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
    opts = {
      -- Provider Configuration
      -- Use OpenCode (via ACP) for chat/questions and code editing
      provider = "opencode", -- Default provider for chat
      
      -- Use Copilot for fast inline auto-suggestions
      -- Note: Copilot is already configured via LazyVim extras and copilot-config.lua
      -- This leverages your existing Copilot subscription for Avante's auto-suggestions
      auto_suggestions_provider = "copilot",

      -- Copilot Provider Configuration
      providers = {
        copilot = {
          -- Use the copilot.lua you already have configured
          -- No additional API key needed - uses your existing subscription
        },
      },

      -- ACP Provider Configuration (OpenCode)
      acp_providers = {
        opencode = {
          command = "opencode",
          args = { "acp" },
          -- Optional: pass environment variables if needed
          -- env = {
          --   OPENCODE_API_KEY = os.getenv("OPENCODE_API_KEY")
          -- },
        },
      },

      -- Behavior Configuration
      behaviour = {
        -- Enable auto-suggestions via Copilot (fast inline completions)
        auto_suggestions = true,
        -- Don't auto-apply changes - require manual review
        auto_apply_diff_after_generation = false,
        -- Only show changed lines in diffs (cleaner UI)
        minimize_diff = true,
        -- Automatically add current file to context when opening chat
        auto_add_current_file = true,
        -- Auto-approve tool permissions (OpenCode tools won't prompt)
        auto_approve_tool_permissions = true,
        -- Use inline buttons for confirmations (less intrusive)
        confirmation_ui_style = "inline_buttons",
        -- Auto-set keymaps (use Avante defaults)
        auto_set_keymaps = true,
      },

      -- Suggestion Configuration (Copilot)
      suggestion = {
        debounce = 600, -- Delay before showing suggestions (ms)
        throttle = 600, -- Request frequency limit
      },

      -- Window Configuration
      windows = {
        position = "right", -- Sidebar position
        wrap = true, -- Wrap text
        width = 30, -- Width as percentage
        sidebar_header = {
          enabled = true,
          align = "center",
          rounded = true,
        },
      },

      -- Default mappings (documented here for reference)
      -- Sidebar:
      --   <Leader>aa - Show sidebar
      --   <Leader>at - Toggle sidebar visibility
      --   <Leader>ar - Refresh sidebar
      --   <Leader>af - Switch sidebar focus
      --   a - Apply change at cursor
      --   A - Apply all changes
      --   r - Retry user request
      --   e - Edit user request
      --   @ - Add file to context
      --   d - Remove file from context
      --   q - Close sidebar
      --
      -- Diff navigation:
      --   ]x - Next conflict
      --   [x - Previous conflict
      --   co - Choose ours (keep current)
      --   ct - Choose theirs (accept suggestion)
      --   cb - Choose both
      --   cc - Choose at cursor
      --
      -- Suggestions (Copilot):
      --   <M-l> - Accept suggestion (Alt+l)
      --   <M-]> - Next suggestion
      --   <M-[> - Previous suggestion
      --   <C-]> - Dismiss suggestion
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      -- Optional but recommended dependencies
      "nvim-tree/nvim-web-devicons", -- Icons
      "hrsh7th/nvim-cmp", -- Completion (already have this)
      "zbirenbaum/copilot.lua", -- Copilot (already have this)
      "folke/snacks.nvim", -- Input UI (already have this)
      {
        -- Image pasting support
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            use_absolute_path = true,
          },
        },
      },
      {
        -- Markdown rendering in Avante buffers
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
}
