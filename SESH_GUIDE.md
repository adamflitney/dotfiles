# Sesh: Multi-Project Workflow Guide

A complete guide to your tmux session management workflow using sesh, Raycast, and Ghostty.

## Overview

Your workflow is built around these principles:
- **Single Ghostty window** - One viewport into all your work
- **tmux as workspace manager** - Each project is a tmux session
- **sesh as the launcher** - Fuzzy-find and switch between projects instantly
- **Raycast for global access** - Trigger sesh from anywhere with a hotkey

```
┌─────────────────────────────────────────────────────────────────┐
│ Ghostty Window                                                   │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ tmux: yoto-club-api                                         │ │
│ │ ┌─────────┬─────────┬─────────┐                             │ │
│ │ │ 1:nvim* │ 2:oc    │ 3:zsh   │  ← windows                 │ │
│ │ └─────────┴─────────┴─────────┘                             │ │
│ │                                                              │ │
│ │  [Your active window content here]                          │ │
│ │                                                              │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                  │
│  Other sessions (backgrounded):                                 │
│  - dotfiles                                                     │
│  - yoto-space-api                                               │
│  - personal-site                                                │
└─────────────────────────────────────────────────────────────────┘
```

## Quick Reference

### Keyboard Shortcuts

| Context | Shortcut | Action |
|---------|----------|--------|
| **Anywhere** | `Ctrl+Space` | Open project picker (via Raycast) |
| **In tmux** | `Ctrl+s Ctrl+j` | Open project picker (popup) |
| **In tmux** | `Ctrl+s Ctrl+k` | Quick switch active sessions only |
| **In tmux** | `Ctrl+s L` | Toggle to last session |
| **In tmux** | `Alt+h` / `Alt+l` | Previous/next window |
| **In tmux** | `Ctrl+s 1/2/3` | Jump to window by number |

### CLI Commands

```bash
sesh                  # Interactive project picker (TUI)
sesh list             # List all projects
sesh list -t          # List only active tmux sessions
sesh connect <name>   # Connect to project by name
sesh switch           # Quick switch between active sessions
sesh <name>           # Shorthand for 'sesh connect <name>'
```

## Daily Workflow

### Starting Your Day

1. Open Ghostty (one window)
2. You'll be in your last tmux session (auto-restored by tmux-continuum)
3. Press `Ctrl+s Ctrl+j` to switch to a different project

### Switching Projects

**From anywhere on your Mac:**
1. Press `Ctrl+Space` (Raycast)
2. Ghostty focuses, sesh picker opens
3. Type to fuzzy search, Enter to select

**From inside the terminal:**
1. Press `Ctrl+s Ctrl+j`
2. Sesh popup appears with all projects
3. Type to search, Enter to select

**Quick switch (active sessions only):**
1. Press `Ctrl+s Ctrl+k`
2. Shows only running sessions (faster)
3. Select to switch

### Within a Project

Each project session has 3 windows:

| Window | Name | Content | Shortcut |
|--------|------|---------|----------|
| 1 | nvim | Neovim with project open | `Ctrl+s 1` |
| 2 | oc | OpenCode AI assistant | `Ctrl+s 2` |
| 3 | zsh | General terminal | `Ctrl+s 3` |

Navigate between windows:
- `Alt+h` - Previous window
- `Alt+l` - Next window
- `Ctrl+s Tab` - Toggle between current and last window

### Ending Your Day

Just close the terminal. Sessions persist automatically:
- tmux-resurrect saves session state
- tmux-continuum restores on next launch
- `detach-on-destroy off` means closing a session switches to another

## Project Discovery

Sesh scans these directories for Git repositories:

```yaml
# ~/.config/sesh/config.yaml
project_directories:
  - ~/Dev
  - ~/dotfiles
```

Edit this file to add more directories.

### Ordering (with zoxide)

Projects are ordered by frecency (frequency + recency):
- Recently used projects appear first
- Frequently used projects are prioritized
- New projects appear at the end

The top 3 most recent projects are pinned at the top for quick access.

## Configuration Files

| File | Purpose |
|------|---------|
| `~/.config/sesh/config.yaml` | Project directories to scan |
| `~/.tmux.conf` | Tmux keybindings and settings |
| `~/.config/ghostty/config` | Ghostty terminal settings |
| `~/dotfiles/raycast/scripts/` | Raycast script commands |

## Setup (One-Time)

### 1. Reload tmux config
```bash
tmux source-file ~/.tmux.conf
# Or press Ctrl+s r inside tmux
```

### 2. Configure Raycast
1. Open Raycast Settings
2. Go to Extensions → Script Commands
3. Click "Add Directories"
4. Select `~/dotfiles/raycast/scripts`
5. Find "Switch Project" command
6. Assign hotkey: `Ctrl+Space`

### 3. Restart Ghostty
Close and reopen Ghostty to enable title passthrough.

### 4. Verify zoxide
```bash
# Check if zoxide is working
zoxide query -l | head -5
```

## Troubleshooting

### Sesh popup doesn't open
- Make sure you're inside a tmux session
- Reload tmux config: `Ctrl+s r`

### Raycast command doesn't work
- Verify Ghostty is running
- Check scripts are executable: `ls -la ~/dotfiles/raycast/scripts/`
- Re-add the scripts directory in Raycast settings

### Window titles not showing
- Restart Ghostty
- Check Ghostty config exists: `cat ~/.config/ghostty/config`

### Projects not found
- Check your config: `cat ~/.config/sesh/config.yaml`
- Verify directories exist and contain Git repos
- Run `sesh list` to see what's discovered

## Tips & Tricks

### Quick Connect
Instead of using the picker, connect directly:
```bash
sesh yoto-club-api
# or
sesh connect yoto-club-api
```

### List Active Sessions
```bash
sesh list -t
# or
tms  # alias for tmux list-sessions
```

### Use with fzf
```bash
sesh connect $(sesh list | fzf)
```

### Kill a Session
```bash
tmk session-name  # alias for tmux kill-session -t
```

## Architecture

```
Raycast (Ctrl+Space)
    │
    ▼
┌─────────┐
│ Ghostty │ ◄── Single window, shows tmux session in title
└────┬────┘
     │
     ▼
┌─────────┐
│  tmux   │ ◄── Manages all sessions, windows, panes
└────┬────┘
     │
     ▼
┌─────────┐
│  sesh   │ ◄── Discovers projects, creates/switches sessions
└────┬────┘
     │
     ▼
┌─────────┐
│ zoxide  │ ◄── Tracks directory frecency for smart ordering
└─────────┘
```

## Related Files in Dotfiles

```
~/dotfiles/
├── tmux/.tmux.conf           # Tmux config with sesh keybindings
├── sesh/.config/sesh/        # Sesh configuration
├── ghostty/.config/ghostty/  # Ghostty terminal config
├── raycast/scripts/          # Raycast script commands
└── SESH_GUIDE.md            # This file
```
