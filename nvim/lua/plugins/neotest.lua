-- Neotest configuration for running tests
-- Supports Vitest (primary) and Jest (occasional)
return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      { "nvim-neotest/neotest-vitest", url = "https://github.com/nvim-neotest/neotest-vitest.git" },
      { "nvim-neotest/neotest-jest", url = "https://github.com/nvim-neotest/neotest-jest.git" },
    },
    opts = {
      adapters = {
        ["neotest-vitest"] = {
          -- Filter directories to improve performance
          filter_dir = function(name)
            return name ~= "node_modules" and name ~= ".git"
          end,
        },
        ["neotest-jest"] = {
          jestCommand = "npm test --",
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        },
      },
      -- Status signs in gutter
      status = {
        enabled = true,
        virtual_text = true, -- Show pass/fail inline
        signs = true,
      },
      -- Show test output in dedicated buffer
      output = {
        enabled = true,
        open_on_run = false, -- Don't auto-open, use keybinding
      },
      -- Test results stay visible until next run
      quickfix = {
        enabled = false, -- Use Trouble instead
        open = false,
      },
      -- No persistent panel, use on-demand
      summary = {
        enabled = true,
        expand_errors = true,
        open = "botright vsplit | vertical resize 50",
      },
      -- Diagnostic integration
      diagnostic = {
        enabled = true,
        severity = vim.diagnostic.severity.ERROR,
      },
      -- Icons for test status
      icons = {
        passed = "✓",
        running = "●",
        failed = "✗",
        skipped = "○",
        unknown = "?",
      },
    },
    config = function(_, opts)
      -- Load adapters
      opts.adapters = {
        require("neotest-vitest")(opts.adapters["neotest-vitest"] or {}),
        require("neotest-jest")(opts.adapters["neotest-jest"] or {}),
      }

      require("neotest").setup(opts)
    end,
    keys = {
      {
        "<leader>tn",
        function()
          require("neotest").run.run()
        end,
        desc = "Run nearest test",
      },
      {
        "<leader>tf",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "Run tests in file",
      },
      {
        "<leader>ta",
        function()
          require("neotest").run.run(vim.fn.getcwd())
        end,
        desc = "Run all tests",
      },
      {
        "<leader>ts",
        function()
          require("neotest").summary.toggle()
        end,
        desc = "Toggle test summary",
      },
      {
        "<leader>to",
        function()
          require("neotest").output.open({ enter = true })
        end,
        desc = "Show test output",
      },
      {
        "<leader>tO",
        function()
          require("neotest").output_panel.toggle()
        end,
        desc = "Toggle test output panel",
      },
      {
        "<leader>tS",
        function()
          require("neotest").run.stop()
        end,
        desc = "Stop tests",
      },
      {
        "]t",
        function()
          require("neotest").jump.next()
        end,
        desc = "Next test",
      },
      {
        "[t",
        function()
          require("neotest").jump.prev()
        end,
        desc = "Previous test",
      },
      {
        "]T",
        function()
          require("neotest").jump.next({ status = "failed" })
        end,
        desc = "Next failed test",
      },
      {
        "[T",
        function()
          require("neotest").jump.prev({ status = "failed" })
        end,
        desc = "Previous failed test",
      },
    },
  },
}
