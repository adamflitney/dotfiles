-- Goto Preview - Peek definitions in floating window
return {
  "rmagatti/goto-preview",
  event = "LspAttach",
  opts = {
    width = 120, -- Width of the floating window
    height = 25, -- Height of the floating window
    border = { "↖", "─", "┐", "│", "┘", "─", "└", "│" }, -- Border characters
    default_mappings = false, -- We define our own keybindings
    debug = false,
    opacity = nil, -- 0-100 opacity level
    resizing_mappings = false,
    post_open_hook = nil,
    post_close_hook = nil,
    references = {
      telescope = require("telescope.themes").get_dropdown({ hide_preview = false }),
    },
    focus_on_open = true, -- Focus preview window on open
    dismiss_on_move = false, -- Stay open when cursor moves
    force_close = true, -- Force close when pressing escape
    bufhidden = "wipe", -- Wipe buffer when closing
    stack_floating_preview_windows = true, -- Stack previews
    preview_window_title = { enable = true, position = "left" },
  },
  keys = {
    {
      "gp",
      "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
      desc = "Peek definition",
    },
    {
      "gP",
      "<cmd>lua require('goto-preview').close_all_win()<CR>",
      desc = "Close all preview windows",
    },
  },
}
