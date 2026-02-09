# Avante.nvim Setup Guide

Your Neovim now has **dual AI integration** for the best of both worlds:

## 🎯 What You Have

### 1. **Copilot** - Fast Inline Suggestions
- Provider: Direct Copilot integration
- Use case: Auto-completions while typing
- Keybinds: `<Tab>` to accept (configured in copilot-config.lua)

### 2. **Avante + OpenCode** - Intelligent Chat & Code Editing
- Provider: OpenCode via ACP
- Use case: Ask questions, request changes, review diffs, apply edits
- Keybinds: See below

### 3. **opencode.nvim** - Terminal Integration
- Provider: OpenCode terminal
- Use case: Full OpenCode TUI in Neovim split
- Keybinds: `<leader>o*` (see opencode.lua)

---

## 📋 Quick Start

### Ask a Question with Code Context
1. **Select code** in visual mode (or just position cursor)
2. **Press `<leader>aa`** to open Avante sidebar
3. **Type your question**: "What does this do?" or "Refactor this to use async/await"
4. **OpenCode responds** with explanation or code changes
5. **Review the diff** shown inline in your buffer
6. **Press `a`** to apply changes at cursor, or **`A`** to apply all

### While Typing (Auto-suggestions)
- **Copilot automatically suggests** completions as ghost text
- **Press `<Tab>`** to accept (priority: snippets → copilot → cmp menu)
- **Press `<M-l>`** (Alt+l) to accept Avante/Copilot suggestions

---

## ⌨️ Keybinds Reference

### Avante Sidebar Commands
| Keybind | Description |
|---------|-------------|
| `<leader>aa` | Show Avante sidebar |
| `<leader>at` | Toggle sidebar visibility |
| `<leader>ar` | Refresh sidebar |
| `<leader>af` | Switch focus to sidebar |
| `<leader>ac` | Add current buffer to context |

### In Avante Sidebar
| Key | Action |
|-----|--------|
| `a` | Apply change at cursor |
| `A` | Apply all changes |
| `r` | Retry request (regenerate) |
| `e` | Edit your question |
| `@` | Add file to context |
| `d` | Remove file from context |
| `q` | Close sidebar |

### Diff Navigation & Resolution
| Keybind | Description |
|---------|-------------|
| `]x` | Next conflict/change |
| `[x` | Previous conflict/change |
| `co` | Choose ours (keep current code) |
| `ct` | Choose theirs (accept AI suggestion) |
| `cb` | Choose both versions |
| `cc` | Choose at cursor position |

### Inline Suggestions (Copilot via Avante)
| Keybind | Description |
|---------|-------------|
| `<M-l>` | Accept suggestion (Alt+l) |
| `<M-]>` | Next suggestion (Alt+]) |
| `<M-[>` | Previous suggestion (Alt+[) |
| `<C-]>` | Dismiss suggestion |

---

## 🔄 Workflow Examples

### Example 1: Refactor a Function
```
1. Visual select the function
2. <leader>aa (open Avante)
3. Type: "Refactor this to use async/await and add error handling"
4. Review the diff inline
5. Press 'a' to apply at cursor or 'A' to apply all
```

### Example 2: Explain Complex Code
```
1. Place cursor on interesting code
2. <leader>aa
3. Type: "Explain what this does and why"
4. Read explanation in sidebar
5. Press 'q' to close when done
```

### Example 3: Add Tests
```
1. Open the file you want to test
2. <leader>aa
3. Type: "@this Write unit tests for this module"
4. Avante suggests test code in a diff
5. Review and apply with 'A'
```

### Example 4: Multi-file Context
```
1. <leader>aa (open Avante)
2. Type: @src/utils.ts Refactor the auth logic to use this pattern
3. Avante has context from both files
4. Apply changes across files
```

---

## 🎨 UI Behavior

### Configured Settings
- ✅ **Manual review** - Changes are NOT auto-applied (you must press 'a' or 'A')
- ✅ **Inline buttons** - Apply buttons appear directly in buffer
- ✅ **Minimize diff** - Only changed lines are shown
- ✅ **Auto-add current file** - Current buffer automatically included in context
- ✅ **Auto-suggestions enabled** - Copilot provides inline suggestions while typing

### Sidebar Position
- **Right side** of the screen (30% width)
- **Wrap text enabled** for readability
- **Rounded borders** for clean look

---

## 🔧 Integration Details

### Copilot (Inline Suggestions)
- Uses your existing Copilot subscription
- Configured via `lazyvim.plugins.extras.ai.copilot`
- Custom Tab behavior in `copilot-config.lua` preserved
- Fast, low-latency completions

### OpenCode (Chat & Editing)
- Runs via ACP protocol (`opencode acp`)
- Full access to OpenCode's tools and features
- Uses context from:
  - Current buffer (auto-added)
  - Selected text
  - Files referenced with `@`
  - Project rules from `AGENTS.md`

### opencode.nvim (Terminal)
- Separate plugin for terminal-based OpenCode
- Keybinds under `<leader>o*`
- Use when you want the full TUI experience
- Both can run simultaneously

---

## 🚀 Next Steps

1. **Try it out**: Open a file and press `<leader>aa`
2. **Test inline suggestions**: Start typing code and watch Copilot suggest
3. **Review keybinds**: Memorize the most common ones (`<leader>aa`, `a`, `A`, `q`)
4. **Customize**: Edit `~/dotfiles/nvim/lua/plugins/avante.lua` if needed
5. **Add project rules**: Create `AGENTS.md` in your project root for project-specific AI behavior

---

## 📚 Documentation

- [Avante.nvim](https://github.com/yetone/avante.nvim)
- [OpenCode ACP Docs](https://opencode.ai/docs/acp/)
- [Copilot.lua](https://github.com/zbirenbaum/copilot.lua)

---

## ⚙️ Configuration Files

- **Avante config**: `~/dotfiles/nvim/lua/plugins/avante.lua`
- **Copilot config**: `~/dotfiles/nvim/lua/plugins/copilot-config.lua`
- **OpenCode config**: `~/dotfiles/nvim/lua/plugins/opencode.lua`

---

## 🐛 Troubleshooting

### Avante sidebar won't open
- Run `:checkhealth avante` to diagnose
- Ensure `opencode` CLI is installed and in PATH
- Try `:AvanteToggle` command directly

### Copilot suggestions not showing
- Check `:Copilot status`
- Ensure you're authenticated: `:Copilot auth`
- Suggestions have 600ms debounce by default

### OpenCode ACP not working
- Test OpenCode CLI: `opencode acp` in terminal
- Check if process starts: `:!ps aux | grep opencode`
- Review error messages in `:messages`

---

Enjoy your enhanced Neovim setup! 🎉
