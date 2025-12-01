# Neovim Configuration Guide

Complete guide for your enhanced LazyVim setup optimized for TypeScript/AWS Lambda/Serverless development.

## Table of Contents
- [Quick Start](#quick-start)
- [Complete Keybinding Reference](#complete-keybinding-reference)
- [Plugin Guide](#plugin-guide)
- [Common Workflows](#common-workflows)
- [Troubleshooting](#troubleshooting)

---

## Quick Start

### Setup Instructions

1. **Pull latest dotfiles:**
   ```bash
   cd ~/dotfiles
   git pull
   ```

2. **Start Neovim:**
   ```bash
   nvim
   # Lazy.nvim will automatically install all plugins (~30 seconds)
   ```

3. **Install external tools:**
   ```bash
   # If not already installed:
   brew install lazygit        # For git TUI
   npm install -g serverless   # For serverless commands
   ```

4. **Verify installation:**
   ```vim
   :Lazy       " Check all plugins are installed
   :checkhealth " Verify no errors
   ```

### Essential Keybindings (First Week)

**Navigation:**
- `gd` - Go to definition
- `gr` - Find all references (Telescope)
- `gp` - Peek definition (floating window)
- `K` - Show documentation

**Testing:**
- `<leader>tn` - Run test under cursor
- `<leader>tf` - Run all tests in file
- `<leader>xt` - Show test results in Trouble

**Terminal:**
- `<leader>tt` - Toggle terminal
- `<leader>gg` - Toggle lazygit
- `jk` - Exit insert/terminal mode (universal)

**File Operations:**
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>e` - Toggle file explorer

---

## Complete Keybinding Reference

### LSP Navigation

| Keybinding | Description | Status |
|------------|-------------|--------|
| `gd` | Go to definition | LazyVim default |
| `gr` | Find references (Telescope) | Enhanced |
| `gi` | Go to implementation | LazyVim default |
| `gt` | Go to type definition | LazyVim default |
| `gp` | Peek definition | NEW |
| `gP` | Close all previews | NEW |
| `K` | Hover documentation | LazyVim default |
| `<leader>ca` | Code actions | LazyVim default |
| `<leader>rn` | Rename symbol | LazyVim default |
| `<leader>ls` | Document symbols (Telescope) | NEW |
| `<leader>lS` | Workspace symbols (Telescope) | NEW |
| `<leader>lr` | LSP references (Telescope) | NEW |
| `<leader>li` | Incoming calls | NEW |
| `<leader>lo` | Outgoing calls | NEW |
| `]d` / `[d` | Next/Previous diagnostic | LazyVim default |
| `]e` / `[e` | Next/Previous error | LazyVim default |

### Testing (Neotest)

| Keybinding | Description |
|------------|-------------|
| `<leader>tn` | Run nearest test |
| `<leader>tf` | Run tests in file |
| `<leader>ta` | Run all tests |
| `<leader>ts` | Toggle test summary |
| `<leader>to` | Show test output |
| `<leader>tO` | Toggle output panel |
| `<leader>tS` | Stop tests |
| `]t` / `[t` | Next/Previous test |
| `]T` / `[T` | Next/Previous failed test |

### Trouble/Diagnostics

| Keybinding | Description | Status |
|------------|-------------|--------|
| `<leader>xx` | Toggle Trouble | LazyVim default |
| `<leader>xw` | Workspace diagnostics | LazyVim default |
| `<leader>xd` | Document diagnostics | LazyVim default |
| `<leader>xq` | Quickfix list | LazyVim default |
| `<leader>xl` | Location list | LazyVim default |
| `<leader>xt` | Test results (neotest) | NEW |

### Terminal (Toggleterm)

| Keybinding | Description |
|------------|-------------|
| `<leader>tt` | Toggle horizontal terminal |
| `<leader>tv` | Toggle vertical terminal |
| `<leader>tf` | Toggle floating terminal |
| `<leader>tl` | Toggle all terminals |
| `<leader>gg` | Toggle lazygit |
| `jk` | Exit terminal insert mode |
| `<Esc>` | Exit terminal insert mode |

### Serverless Framework

| Keybinding | Command | Description |
|------------|---------|-------------|
| `<leader>sd` | `:ServerlessDeploy` | Deploy to AWS |
| `<leader>si` | `:ServerlessInvoke` | Invoke function locally |
| `<leader>sl` | `:ServerlessLogs` | Tail function logs |
| `<leader>so` | `:ServerlessOffline` | Start serverless offline |
| `<leader>sI` | `:ServerlessInfo` | Show deployment info |

**Note:** All serverless commands use `eu-west-2` region by default.

### TypeScript

| Keybinding | Description |
|------------|-------------|
| `<leader>co` | Organize imports (manual) |
| `<leader>cM` | Add missing imports |
| `<leader>cR` | Remove unused imports |
| `<leader>cu` | Remove unused variables |
| `<leader>cD` | Fix all auto-fixable |
| `<leader>tc` | TypeScript compiler check |

### File Operations

| Keybinding | Description | Status |
|------------|-------------|--------|
| `<leader>e` | Toggle file explorer | LazyVim default |
| `<leader>ff` | Find files | LazyVim default |
| `<leader>fg` | Live grep | LazyVim default |
| `<leader>fb` | Find buffers | LazyVim default |
| `<leader>fo` | Recent files | LazyVim default |
| `<leader>fr` | Find and replace (Spectre) | NEW |
| `<leader>fw` | Find word under cursor | NEW |

### Todo Comments

| Keybinding | Description |
|------------|-------------|
| `<leader>st` | Search all todos (Telescope) |
| `<leader>sT` | Todos in Trouble |
| `]t` / `[t` | Next/Previous todo |

### Sessions

| Keybinding | Description |
|------------|-------------|
| `<leader>qs` | Restore session |
| `<leader>ql` | Restore last session |
| `<leader>qd` | Don't save current session |

### Window Management

| Keybinding | Description | Status |
|------------|-------------|--------|
| `<C-h/j/k/l>` | Navigate splits | vim-tmux-navigator |
| `<leader>\|` | Split vertical | NEW |
| `<leader>-` | Split horizontal | NEW |

### Escape Sequences

| Keybinding | Context | Description |
|------------|---------|-------------|
| `jk` | Insert mode | Exit to normal mode |
| `jk` | Terminal mode | Exit to normal mode |
| `<Esc>` | Insert/Terminal | Standard escape |

---

## Plugin Guide

### Neotest - Test Runner

**What it does:** Runs Vitest and Jest tests with inline results.

**How to use:**
1. Open a test file (`.test.ts` or `.spec.ts`)
2. Place cursor on a test case
3. Press `<leader>tn` to run that test
4. Results appear inline with ✓ or ✗
5. Press `<leader>xt` to see failures in Trouble
6. Jump to exact failing line with `<CR>`

**Configuration:**
- Tests run once (not in watch mode)
- Results persist until next run
- Virtual text shows pass/fail inline
- No auto-run on save

---

### Toggleterm - Terminal Manager

**What it does:** Better terminal management with persistent terminals.

**Terminal types:**
- **Horizontal** (15 lines, bottom): `<leader>tt`
- **Vertical** (40% width, right): `<leader>tv`
- **Floating** (90% size, center): `<leader>tf`

**Features:**
- Terminals persist between toggles
- Opens in insert mode (ready to type)
- `jk` to exit insert mode
- Directory follows current file

**Tips:**
- Use horizontal for quick commands
- Use vertical for longer output
- Floating for full-screen tasks

---

### Lazygit Integration

**What it does:** Beautiful git TUI in a floating terminal.

**How to use:**
1. Press `<leader>gg` to open lazygit
2. Navigate with `j/k`
3. Stage files with `<space>`
4. Commit with `c`
5. Push with `P`
6. Quit with `q`

**Learn lazygit:** https://github.com/jesseduffield/lazygit

---

### Goto Preview

**What it does:** Peek at definitions in a floating window.

**How to use:**
1. Place cursor on a function/variable
2. Press `gp` to peek definition
3. Window shows definition without losing context
4. Press `<Esc>` to close
5. Or jump to file with `gd` from preview

**Use case:** Quickly check a function signature without losing your place.

---

### LSP Navigation Enhancements

**What changed:**
- `gr` now uses Telescope (fuzzy search + preview)
- Added symbol search: `<leader>ls` (document), `<leader>lS` (workspace)
- Inlay hints show TypeScript types inline
- Better call hierarchy: `<leader>li/lo`

**Tips:**
- Use `gr` instead of default LSP references
- Search symbols project-wide with `<leader>lS`
- Inlay hints can be toggled in LSP menu

---

### Trouble Enhanced

**What it does:** Better error/diagnostic/test navigation.

**How to use:**
1. Press `<leader>xx` to toggle Trouble
2. Navigate with `j/k`
3. Press `<CR>` to jump to item
4. Press `<leader>xt` for test results specifically

**Integration:**
- Neotest results appear in Trouble
- Quickfix items show in Trouble
- Better than default quickfix window

---

### Serverless Framework Commands

**Available commands:**

```vim
:ServerlessDeploy       " Deploy to eu-west-2
:ServerlessInvoke      " Invoke function (prompts for name)
:ServerlessLogs        " Tail logs (prompts for name)
:ServerlessOffline     " Start serverless offline
:ServerlessInfo        " Show stack info
:ServerlessRemove      " Remove stack (confirmation required)
```

**How to use:**
1. Press `<leader>sd` to deploy
2. Terminal opens showing deployment progress
3. Terminal persists after completion
4. Errors show in Trouble if any

**Tips:**
- Run `<leader>so` first to test locally
- Use `<leader>si` to invoke specific functions
- Tail logs with `<leader>sl` for debugging

---

### TypeScript Tools

**Features:**
- **Manual import organization:** `<leader>co`
- **Inlay hints:** Shows inferred types inline
- **Compiler check:** `:TSC` shows build errors
- **Code actions:** `<leader>ca` for TypeScript-specific fixes

**Workflow:**
1. Write code with auto-completion
2. Imports auto-suggest but don't auto-add
3. Press `<leader>co` when needed to organize
4. Run `:TSC` before committing to catch type errors

---

### YAML/Serverless Support

**What it does:** Schema validation and completion for `serverless.yml`.

**How to use:**
1. Open `serverless.yml`
2. Type and get auto-completion
3. Hover over properties for documentation
4. Validation errors show inline

**Supported schemas:**
- Serverless Framework
- AWS CloudFormation
- AWS SAM

---

### Quality of Life Features

#### Todo Comments
- Highlights: `TODO`, `FIXME`, `HACK`, `WARN`, `PERF`, `NOTE`, `TEST`
- Search all: `<leader>st`
- Jump: `]t` / `[t`

#### Spectre (Search/Replace)
- Project-wide search and replace
- Open with `<leader>fr`
- Preview changes before applying
- Regex support

#### Better Quickfix (nvim-bqf)
- Auto-preview in floating window
- Filter results with fzf
- Better navigation

#### Session Management
- Auto-saves per project
- Restore with `<leader>qs`
- Remembers open files, layout, cursor position

---

## Common Workflows

### Workflow 1: Navigate Unfamiliar Code

1. Open file with `<leader>ff`
2. Find function with `<leader>ls` (document symbols)
3. Jump to definition with `gd`
4. See all usages with `gr` (Telescope)
5. Check type definition with `gt`
6. Peek implementation with `gp` without losing place

**Time saved:** ~2 minutes per investigation

---

### Workflow 2: Run and Debug Tests

1. Open test file
2. Run specific test: `<leader>tn`
3. See inline ✗ if failed
4. Open Trouble: `<leader>xt`
5. Jump to error: `<CR>`
6. Fix the issue
7. Rerun same test: `<leader>tn`

**Time saved:** ~1 minute per test iteration

---

### Workflow 3: Deploy Lambda Function

1. Make code changes
2. Organize imports: `<leader>co`
3. Check types: `:TSC`
4. Run tests: `<leader>tf`
5. Test locally: `<leader>so` (serverless offline)
6. Invoke locally: `<leader>si`
7. Deploy: `<leader>sd`
8. Check logs: `<leader>sl`

**Time saved:** ~5 minutes per deployment

---

### Workflow 4: Search and Replace Across Project

1. Press `<leader>fr` (opens Spectre)
2. Type search pattern (e.g., `const`)
3. Type replace pattern (e.g., `let`)
4. Preview all changes
5. Press `<leader>R` to replace all

**Time saved:** ~10 minutes vs manual find/replace

---

### Workflow 5: Work with Git

1. Make changes
2. Open lazygit: `<leader>gg`
3. Review diffs with `<Tab>`
4. Stage hunks with `<space>`
5. Commit with `c`, write message
6. Push with `P`
7. Close with `q`

**Time saved:** ~3 minutes vs command line

---

## Troubleshooting

### Plugins Not Installing

**Symptom:** Lazy.nvim shows errors on startup

**Solution:**
```vim
:Lazy sync        " Sync all plugins
:Lazy clean       " Clean unused plugins
:Lazy update      " Update all plugins
```

### LSP Not Starting

**Symptom:** No completion, no go-to-definition

**Solution:**
```vim
:LspInfo          " Check LSP status
:Mason            " Verify language servers installed
```

Make sure `typescript-language-server` and `yaml-language-server` are installed in Mason.

### Tests Not Running

**Symptom:** `<leader>tn` does nothing

**Solution:**
1. Check test file pattern: `*.test.ts` or `*.spec.ts`
2. Verify vitest/jest is installed: `npm list vitest jest`
3. Check neotest status: `:Neotest`

### Terminal Not Opening

**Symptom:** `<leader>tt` does nothing

**Solution:**
```vim
:messages         " Check for errors
:ToggleTerm       " Try manual command
```

Check that toggleterm is installed in `:Lazy`.

### Lazygit Not Found

**Symptom:** Error when pressing `<leader>gg`

**Solution:**
```bash
brew install lazygit
```

### Serverless Commands Fail

**Symptom:** Serverless commands error

**Solution:**
1. Install serverless: `npm install -g serverless`
2. Check AWS credentials: `aws configure`
3. Verify serverless.yml exists

### Inlay Hints Not Showing

**Symptom:** No type hints inline

**Solution:**
```vim
:lua vim.lsp.inlay_hint.enable(true)  " Enable hints
```

Or toggle in LSP menu.

### Keybinding Conflicts

**Symptom:** Keybinding does something unexpected

**Solution:**
```vim
:map <leader>tn   " Check what it's mapped to
:verbose map gr   " See where mapping is defined
```

All new keybindings avoid LazyVim defaults.

### Performance Issues

**Symptom:** Lag or slowness

**Solution:**
1. Disable inlay hints: `:lua vim.lsp.inlay_hint.enable(false)`
2. Reduce treesitter parsers: Edit `lazy-lock.json`
3. Check large files: Use `:set foldmethod=manual` for big files

### Session Not Restoring

**Symptom:** `<leader>qs` doesn't restore files

**Solution:**
- Sessions save automatically on exit
- Make sure you quit with `:qa` not force-quit
- Check session dir: `~/.local/state/nvim/sessions/`

---

## Learning Resources

**LazyVim:**
- Official docs: https://www.lazyvim.org
- Keymaps reference: https://www.lazyvim.org/keymaps

**Neovim LSP:**
- `:help lsp`
- `:help vim.lsp`

**Telescope:**
- `:help telescope`
- Tutorial: https://github.com/nvim-telescope/telescope.nvim

**Neotest:**
- Docs: https://github.com/nvim-neotest/neotest

**Lazygit:**
- Keybindings: Press `?` in lazygit
- Guide: https://github.com/jesseduffield/lazygit

---

## Next Steps

### Week 1: Master Core Navigation
- Practice `gd`, `gr`, `gi` daily
- Use `<leader>tn` for tests
- Get comfortable with terminal (`<leader>tt`)

### Week 2: Integrate Workflow
- Use lazygit for all git operations
- Deploy with serverless commands
- Try search/replace with Spectre

### Week 3: Optimize
- Customize keybindings if desired
- Add your own snippets
- Fine-tune plugin settings

### Week 4: Advanced Features
- Create custom commands
- Explore all Telescope pickers
- Master Trouble navigation

---

## Customization

All configurations are in `~/dotfiles/nvim/lua/plugins/`.

To disable a plugin, remove or rename its file:
```bash
cd ~/dotfiles/nvim/lua/plugins
mv neotest.lua neotest.lua.disabled
```

To modify keybindings:
```bash
nvim ~/dotfiles/nvim/lua/config/keymaps.lua
```

To change settings:
```bash
nvim ~/dotfiles/nvim/lua/config/options.lua
```

---

## Support

**Issues with this config:**
- Check `:checkhealth`
- Review `:messages`
- Read plugin docs in `:Lazy`

**LazyVim issues:**
- LazyVim discussions: https://github.com/LazyVim/LazyVim/discussions

**Plugin-specific issues:**
- Check plugin GitHub repo
- Read plugin documentation with `:help plugin-name`

---

**Last updated:** 2025-12-01
**Config version:** 1.0.0
**LazyVim version:** Compatible with latest LazyVim
