return {
  {
    "nvim-telescope/telescope.nvim",
    setup = {
      defaults = {
        file_ignore_patterns = { "node_modules/*" },
        initial_mode = "normal",
      },
    },
  },
  -- Telescope project extension
  {
    "nvim-telescope/telescope-project.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { "<leader>fp", "<cmd>Telescope project<cr>", desc = "Projects" },
    },
    config = function()
      require("telescope").load_extension("project")
    end,
  },
}
