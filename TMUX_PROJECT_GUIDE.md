# Tmux Project Management Guide

Complete guide for managing multiple development projects with tmux, tmuxinator, neovim, and OpenCode.

## 📋 Table of Contents

- [Quick Start](#quick-start)
- [Setup on New Machine](#setup-on-new-machine)
- [Daily Workflow](#daily-workflow)
- [Project Management](#project-management)
- [Navigation & Keybindings](#navigation--keybindings)
- [Session Management](#session-management)
- [Advanced Usage](#advanced-usage)
- [Tips & Tricks](#tips--tricks)
- [Troubleshooting](#troubleshooting)

---

## 🚀 Quick Start

### Start a Project
```bash
# Start a specific project
tm yoto-club-api

# Or use fuzzy finder to select from all projects
tm
```

Your workspace opens with 3 windows:
1. **editor** - Neovim (opens automatically)
2. **opencode** - OpenCode AI assistant (auto-starts)
3. **terminal** - Empty shell ready for commands

### Navigate Windows
- `Alt+Shift+L` - Next window (editor → opencode → terminal)
- `Alt+Shift+H` - Previous window
- `Ctrl+s 1/2/3` - Jump directly to window 1, 2, or 3

### Switch Projects
- `Ctrl+s Ctrl+j` - Show visual session chooser
- `tm <project-name>` - Switch to another project
- `tms` - List all active sessions

### Detach & Reattach
- `Ctrl+s d` - Detach (session keeps running in background)
- `tm <project>` - Reattach later (everything restored as you left it)

---

## 🛠️ Setup on New Machine

### Prerequisites
```bash
# Install required tools
brew install tmux tmuxinator fzf neovim

# Install OpenCode (if not already installed)
brew install opencode
```

### Install Dotfiles
```bash
# Clone your dotfiles repo
git clone https://github.com/adamflitney/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### Create Symlinks
```bash
# Tmux config
ln -sf ~/dotfiles/tmux/tmux.conf ~/.tmux.conf

# Tmuxinator projects
ln -sf ~/dotfiles/tmuxinator ~/.config/tmuxinator

# Neovim config
ln -sf ~/dotfiles/nvim ~/.config/nvim

# Create .local/bin if it doesn't exist
mkdir -p ~/.local/bin

# Symlink scripts (optional - scripts are also in PATH via zsh config)
ln -sf ~/dotfiles/scripts/tm ~/.local/bin/tm
ln -sf ~/dotfiles/scripts/tmn ~/.local/bin/tmn
```

### Configure Shell
Add to your `~/.zshrc`:
```bash
# Source tmux project management aliases
source ~/dotfiles/zsh/tmux-aliases.zsh
```

Then reload:
```bash
source ~/.zshrc
```

### Install Tmux Plugin Manager (TPM)
```bash
# Clone TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Start tmux
tmux

# Install plugins (inside tmux)
# Press: Ctrl+s I (capital I)
```

### Verify Installation
```bash
# Check tmuxinator is working
tml

# Should show your projects:
# tmuxinator projects:
# yoto-club-api
# yoto-user-api

# Test launching a project
tm yoto-club-api
```

---

## 📅 Daily Workflow

### Morning - Start Working

```bash
# Option 1: Direct launch
tm yoto-club-api

# Option 2: Fuzzy find and select
tm
# Use arrow keys to select, Enter to launch
```

**What happens:**
1. Tmux session starts with name "yoto-club-api"
2. Window 1 opens with neovim
3. Window 2 opens with OpenCode
4. Window 3 opens with a terminal
5. All windows are in the project root directory

### During Work - Navigate

```bash
# You're in neovim (window 1), coding away
# Need to ask OpenCode something?
Alt+Shift+L              # Switch to OpenCode window
# Ask your question
Alt+Shift+H              # Back to editor

# Need to run tests?
Ctrl+s 3                 # Jump directly to terminal
npm test                 # Run your tests
Ctrl+s 1                 # Back to editor
```

### Switch to Another Project

```bash
# Visual chooser (recommended)
Ctrl+s Ctrl+j
# Use arrow keys, select yoto-user-api, press Enter

# Or from any terminal
tm yoto-user-api
```

### Lunch Break - Detach

```bash
Ctrl+s d                 # Detach from tmux
# Close your terminal - sessions keep running
```

### Back from Lunch - Reattach

```bash
# Open terminal and reattach
tm yoto-club-api
# Everything exactly as you left it
```

### End of Day

```bash
# Just close your terminal!
# Sessions persist and will auto-restore after reboot
# (thanks to tmux-continuum)
```

---

## 📦 Project Management

### View All Projects
```bash
tml                      # List all tmuxinator projects
tms                      # List active tmux sessions
```

### Create New Project

**Method 1: Quick Script**
```bash
# Create template with default path (~/Dev/project-name)
tmn yoto-space-api

# Create with custom path
tmn yoto-space-api ~/code/space-api

# Output:
# ✅ Created project template: ~/dotfiles/tmuxinator/yoto-space-api.yml
# 🚀 Start it with: tm yoto-space-api
```

**Method 2: Manual Creation**
```bash
# Create a new file in ~/dotfiles/tmuxinator/
nvim ~/dotfiles/tmuxinator/my-new-project.yml
```

Example template:
```yaml
name: my-new-project
root: ~/Dev/my-new-project

windows:
  - editor:
      panes:
        - nvim
  - opencode:
      panes:
        - opencode
  - terminal:
      panes:
        - # empty, just a shell
```

**Method 3: Template with Custom Commands**
```yaml
name: my-api
root: ~/Dev/my-api

windows:
  - editor:
      panes:
        - nvim
  - opencode:
      panes:
        - opencode
  - terminal:
      panes:
        - npm install && npm run dev  # Auto-start dev server
```

### Commit New Projects to Git
```bash
cd ~/dotfiles
git add tmuxinator/my-new-project.yml
git commit -m "Add my-new-project tmuxinator template"
git push
```

---

## ⌨️ Navigation & Keybindings

### Window Navigation (Most Used)
| Keybinding | Action |
|------------|--------|
| `Ctrl+Alt+l` | Next window (most reliable) |
| `Ctrl+Alt+h` | Previous window (most reliable) |
| `Ctrl+s Tab` | Toggle between current and last window |
| `Ctrl+s n` | Next window |
| `Ctrl+s p` | Previous window |
| `Ctrl+s 1` | Jump to window 1 (editor) |
| `Ctrl+s 2` | Jump to window 2 (opencode) |
| `Ctrl+s 3` | Jump to window 3 (terminal) |
| `Alt+Shift+H/L` | Previous/next window (if terminal supports) |
| `Ctrl+s c` | Create new window |
| `Ctrl+s ,` | Rename window |
| `Ctrl+s &` | Kill current window |

### Session Navigation
| Keybinding | Action |
|------------|--------|
| `Ctrl+s Ctrl+j` | Session chooser (tree view) |
| `Ctrl+s s` | Quick session list |
| `Ctrl+s d` | Detach from session |
| `Ctrl+s $` | Rename session |

### Pane Navigation (if you split windows)
| Keybinding | Action |
|------------|--------|
| `Ctrl+s \\` | Split horizontal |
| `Ctrl+s -` | Split vertical |
| `Ctrl+s h/j/k/l` | Navigate panes (vim-style) |
| `Ctrl+s z` | Zoom/unzoom pane (fullscreen toggle) |
| `Ctrl+s x` | Kill pane |
| `Ctrl+s H/J/K/L` | Resize pane |

### Copy Mode
| Keybinding | Action |
|------------|--------|
| `Ctrl+s [` | Enter copy mode |
| `v` | Begin selection (in copy mode) |
| `y` | Copy selection (in copy mode) |
| `Ctrl+s ]` | Paste |

### Misc
| Keybinding | Action |
|------------|--------|
| `Ctrl+s r` | Reload tmux config |
| `Ctrl+s ?` | Show all keybindings |

---

## 🎯 Session Management

### Shell Commands
```bash
# List sessions
tms                              # Alias for: tmux list-sessions

# Attach to session
tma yoto-club-api               # Alias for: tmux attach-session -t

# Kill session
tmk yoto-club-api               # Alias for: tmux kill-session -t

# Kill all sessions
tmux kill-server

# Create session without tmuxinator
tmux new-session -s my-session

# Rename current session (from within tmux)
Ctrl+s $
```

### Session Persistence

**Auto-save** (every 15 minutes)
- Handled by `tmux-continuum` plugin
- Saves all sessions, windows, panes, and programs
- Saves to `~/.tmux/resurrect/`

**Auto-restore** (on reboot)
- Enabled with `set -g @continuum-restore 'on'`
- Sessions automatically restore after computer restart
- Works seamlessly - you won't notice anything

**Manual save/restore**
```bash
# Inside tmux, save current state
Ctrl+s Ctrl+s

# Inside tmux, restore saved state
Ctrl+s Ctrl+r
```

---

## 🔧 Advanced Usage

### Custom Project Layouts

**Two Editors Side-by-Side**
```yaml
name: dual-editor
root: ~/Dev/my-project

windows:
  - editor:
      layout: even-horizontal
      panes:
        - nvim src/
        - nvim tests/
  - opencode:
      panes:
        - opencode
  - terminal:
      panes:
        - 
```

**Split Terminal**
```yaml
name: split-terminal
root: ~/Dev/my-project

windows:
  - editor:
      panes:
        - nvim
  - opencode:
      panes:
        - opencode
  - terminal:
      layout: even-vertical
      panes:
        - npm run dev
        - # empty for commands
```

**Pre-run Commands**
```yaml
name: auto-setup
root: ~/Dev/my-project

windows:
  - editor:
      panes:
        - nvim
  - opencode:
      panes:
        - opencode
  - terminal:
      panes:
        - |
          fnm use
          npm install
          npm run dev
```

### Environment Variables Per Project
```yaml
name: my-project
root: ~/Dev/my-project

pre_window: |
  export AWS_PROFILE=dev
  export NODE_ENV=development

windows:
  - editor:
      panes:
        - nvim
  - opencode:
      panes:
        - opencode
  - terminal:
      panes:
        - echo "AWS Profile: $AWS_PROFILE"
```

### Multiple Terminals
```yaml
name: multi-terminal
root: ~/Dev/my-project

windows:
  - editor:
      panes:
        - nvim
  - opencode:
      panes:
        - opencode
  - dev:
      panes:
        - npm run dev
  - test:
      panes:
        - npm run test:watch
  - logs:
      panes:
        - tail -f logs/app.log
```

---

## 💡 Tips & Tricks

### 1. Zoom a Window (Fullscreen)
```bash
# Make current window fullscreen
Ctrl+s z

# Press again to restore
Ctrl+s z
```

### 2. Mouse Support
- Click on windows to switch
- Click on panes to focus
- Scroll with mouse wheel
- Drag pane borders to resize

### 3. Search in Terminal History
```bash
# Enter copy mode
Ctrl+s [

# Search backwards
Ctrl+s

# Search forwards
n
```

### 4. Clear Terminal Properly
```bash
# Clear screen (but keep history)
Ctrl+l

# Clear screen and scrollback
clear && printf '\e[3J'
```

### 5. Rename Sessions on the Fly
```bash
# Rename current session
Ctrl+s $
# Type new name, press Enter
```

### 6. Quick Project Switching with Fuzzy Find
```bash
# Just type 'tm' with no args
tm

# Then type to filter:
# - 'club' shows yoto-club-api
# - 'user' shows yoto-user-api
# Arrow keys to select, Enter to launch
```

### 7. Persist OpenCode Sessions
OpenCode maintains its own session state, so when you switch projects and come back, your OpenCode history is preserved.

### 8. Neovim Session Restoration
Your neovim setup uses `persistence.nvim`, which automatically saves:
- Open buffers
- Window layout
- Cursor positions
- Folds

Restore with:
- `<leader>qs` - Restore session for current directory
- `<leader>ql` - Restore last session
- `<leader>qd` - Don't save current session

### 9. Work on Multiple Projects Simultaneously
```bash
# Start first project
tm yoto-club-api

# Open new terminal window (or split)
# Start second project
tm yoto-user-api

# Switch between them
# Option 1: From within tmux
Ctrl+s Ctrl+j

# Option 2: From new terminal
tm yoto-club-api
```

### 10. Status Bar Shows Project Name
Always visible at top of screen:
```
 🚀 yoto-club-api | 1:editor* 2:opencode 3:terminal
```

---

## 🐛 Troubleshooting

### Sessions Not Restoring After Reboot

**Check if auto-restore is enabled:**
```bash
tmux show-option -g @continuum-restore
# Should output: on
```

**If it shows "off" or nothing:**
```bash
# Edit tmux.conf
nvim ~/dotfiles/tmux/tmux.conf

# Make sure this line exists (not commented):
set -g @continuum-restore 'on'

# Reload config
tmux source ~/.tmux.conf
```

### Neovim Colors Look Wrong

**Ensure true color support:**
```bash
echo $TERM
# Should output: tmux-256color or screen-256color
```

**Fix if needed:**
```bash
# Add to your shell config (~/.zshrc)
export TERM=tmux-256color

# Reload shell
source ~/.zshrc
```

### Scripts Not Found

**Check PATH:**
```bash
echo $PATH | grep dotfiles
# Should see: /Users/adamflitney/dotfiles/scripts
```

**Fix if needed:**
```bash
# Make sure this line is in ~/.zshrc
source ~/dotfiles/zsh/tmux-aliases.zsh

# Reload shell
source ~/.zshrc
```

### Tmuxinator Symlink Broken

**Restore symlink:**
```bash
~/dotfiles/scripts/restore-tmuxinator-symlink.sh
```

**Or manually:**
```bash
rm -rf ~/.config/tmuxinator
ln -sf ~/dotfiles/tmuxinator ~/.config/tmuxinator
```

### OpenCode Not Starting

**Check if OpenCode is installed:**
```bash
which opencode
# Should output: /opt/homebrew/bin/opencode
```

**Install if missing:**
```bash
brew install opencode
```

**Start manually if auto-start fails:**
```bash
# From within tmux window 2
opencode
```

### Project Template Not Found

**List available projects:**
```bash
tml
```

**Check if template file exists:**
```bash
ls -la ~/dotfiles/tmuxinator/
```

**Create missing template:**
```bash
tmn yoto-club-api ~/Dev/yoto-club-api
```

### Can't Switch Between Neovim and Tmux Panes

**Check vim-tmux-navigator plugin:**
```bash
# Inside tmux, check if plugin is loaded
tmux show-option -g @plugin | grep vim-tmux-navigator
```

**Reinstall plugins if missing:**
```bash
# Inside tmux
Ctrl+s I
```

### Tmux Session Not Starting

**Check tmux version:**
```bash
tmux -V
# Should be 3.0 or higher
```

**Check for errors in config:**
```bash
tmux -f ~/dotfiles/tmux/tmux.conf
# Look for error messages
```

**Start tmux in verbose mode:**
```bash
tmux -vv
```

### Commands Run Slowly in Tmux

**Check escape-time setting:**
```bash
tmux show-option -g escape-time
# Should be: 0
```

**Fix if needed:**
```bash
# Already set in config, but verify:
grep escape-time ~/dotfiles/tmux/tmux.conf
# Should show: set -g escape-time 0
```

---

## 📚 Additional Resources

### Tmux Documentation
- [Tmux man page](https://man.openbsd.org/tmux)
- [Tmux wiki](https://github.com/tmux/tmux/wiki)

### Tmuxinator Documentation
- [Tmuxinator GitHub](https://github.com/tmuxinator/tmuxinator)

### Related Configs
- Your neovim config: `~/dotfiles/nvim/`
- Your tmux config: `~/dotfiles/tmux/tmux.conf`
- Your zsh aliases: `~/dotfiles/zsh/tmux-aliases.zsh`

### Dotfiles Repo
- [Your dotfiles on GitHub](https://github.com/adamflitney/dotfiles)

---

## 🎓 Learning Path

### Beginner
1. Start with one project: `tm yoto-club-api`
2. Learn window navigation: `Alt+Shift+L/H`
3. Practice detaching/reattaching: `Ctrl+s d`, then `tm yoto-club-api`
4. Try the session chooser: `Ctrl+s Ctrl+j`

### Intermediate
1. Create a new project: `tmn my-project`
2. Customize a project template
3. Learn to split panes: `Ctrl+s \\` and `Ctrl+s -`
4. Use copy mode: `Ctrl+s [`, select with `v`, copy with `y`

### Advanced
1. Create custom layouts for different project types
2. Add pre-run commands to templates
3. Use environment variables per project
4. Create bash functions to enhance workflow
5. Integrate with other tools (git, docker, etc.)

---

## 🚀 Next Steps

Now that you have this guide, try:

1. **Today:** Start one project with `tm` and practice window navigation
2. **This Week:** Create templates for all your active projects
3. **This Month:** Customize templates with pre-run commands
4. **Ongoing:** Share your dotfiles repo with your team

Happy coding! 🎉
