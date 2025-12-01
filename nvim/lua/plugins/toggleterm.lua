-- Toggleterm configuration for terminal management
-- Supports persistent terminals with lazygit integration
return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      -- Terminal sizes
      size = function(term)
        if term.direction == "horizontal" then
          return 15 -- Lines for horizontal split
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4 -- 40% of screen width
        end
      end,
      -- Open terminals in insert mode
      open_mapping = nil, -- We use custom keybindings
      start_in_insert = true,
      insert_mappings = false, -- Don't map in insert mode (we use jk)
      terminal_mappings = true, -- Allow mappings in terminal mode
      persist_size = true,
      persist_mode = true, -- Keep terminal in insert mode
      direction = "horizontal", -- Default direction
      close_on_exit = true, -- Close terminal window on process exit
      shell = vim.o.shell, -- Use default shell
      -- Floating terminal config
      float_opts = {
        border = "curved",
        width = math.floor(vim.o.columns * 0.9),
        height = math.floor(vim.o.lines * 0.9),
        winblend = 0,
      },
      -- Better terminal window look
      highlights = {
        Normal = {
          link = "Normal",
        },
        NormalFloat = {
          link = "NormalFloat",
        },
        FloatBorder = {
          link = "FloatBorder",
        },
      },
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)

      -- Terminal keymaps for navigation
      function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts) -- Universal escape
        vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
        -- Navigation with tmux-navigator still works
      end

      -- Auto command to set keymaps for terminal
      vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
    end,
    keys = {
      {
        "<leader>tt",
        "<cmd>ToggleTerm direction=horizontal<cr>",
        desc = "Toggle horizontal terminal",
      },
      {
        "<leader>tv",
        "<cmd>ToggleTerm direction=vertical<cr>",
        desc = "Toggle vertical terminal",
      },
      {
        "<leader>tf",
        "<cmd>ToggleTerm direction=float<cr>",
        desc = "Toggle floating terminal",
      },
      {
        "<leader>tl",
        "<cmd>ToggleTermToggleAll<cr>",
        desc = "Toggle all terminals",
      },
    },
  },
  -- Lazygit integration
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    keys = {
      {
        "<leader>gg",
        "<cmd>LazyGit<cr>",
        desc = "LazyGit",
      },
    },
  },
}
