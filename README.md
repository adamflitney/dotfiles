# Dotfiles

My configuration files for macOS, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Quick Setup

```bash
git clone git@github.com:adamflitney/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup.sh
```

This will:
- Install stow (if needed)
- Symlink all configurations to their proper locations
- Set up hourly auto-sync to GitHub

## Packages

| Package | Target | Description |
|---------|--------|-------------|
| `nvim` | `~/.config/nvim` | LazyVim configuration with persistence, telescope, and OpenCode integration |
| `tmux` | `~/.tmux.conf` | Terminal multiplexer with session persistence, vim navigation |
| `tmuxinator` | `~/.config/tmuxinator` | Project templates for quick workspace setup |
| `zsh` | `~/.zshrc`, `~/.zsh/` | Shell config with Oh My Zsh, Starship prompt, and aliases |
| `scripts` | `~/.local/bin/` | Utility scripts (tm, tmn, dotfiles-sync) |
| `starship` | `~/.config/starship.toml` | Minimal Starship prompt configuration |

## Manual Installation

### Install Individual Packages

```bash
cd ~/dotfiles
stow nvim      # Neovim config
stow tmux      # Tmux config
stow tmuxinator # Tmuxinator templates
stow zsh       # Zsh configuration
stow scripts   # tm, tmn, and dotfiles-sync scripts
stow starship  # Starship prompt
```

### Uninstall a Package

```bash
stow -D <package>  # Remove symlinks for a package
```

### Preview Changes (Dry Run)

```bash
stow -n -v <package>  # Show what would happen without making changes
```

## Manual Setup (Not Managed by Stow)

### Karabiner-Elements

```bash
ln -sf ~/dotfiles/karabiner/karabiner.json ~/.config/karabiner/karabiner.json
```

### LeaderKey

```bash
ln -sf ~/dotfiles/leaderkey/config.json ~/Library/Application\ Support/Leader\ Key/config.json
```

## Auto-Sync

Dotfiles are automatically committed and pushed to GitHub every hour via a LaunchAgent.

### Commands

| Alias | Description |
|-------|-------------|
| `dots` | Show git status of dotfiles |
| `dotd` | Show git diff of dotfiles |
| `dotl` | Show recent sync log |
| `dotsync` | Manually trigger sync |

### Log Location

```bash
tail -f ~/.local/share/dotfiles-sync.log
```

## Tmux Project Management

| Command | Description |
|---------|-------------|
| `tm` | Fuzzy-find and start/attach to a tmuxinator project |
| `tm <name>` | Start or attach to a specific project |
| `tmn <name> [path]` | Create a new tmuxinator project template |
| `tml` | List all tmuxinator projects |
| `tms` | List active tmux sessions |
| `tma <name>` | Attach to a tmux session |
| `tmk <name>` | Kill a tmux session |

## Configs Overview

- **Karabiner-Elements**: Maps shift+space to F12 (leader key), Caps Lock to Ctrl/Esc
- **Neovim**: LazyVim configuration with persistence, telescope, and OpenCode integration
- **Tmux**: Terminal multiplexer with session persistence, vim navigation, and project management
- **Tmuxinator**: Project templates for quick workspace setup (neovim + OpenCode + terminal)
- **LeaderKey**: F12 leader key shortcuts for app launching (t=Ghostty, b=browsers, r=Raycast, n=Obsidian)
- **Zsh**: Oh My Zsh with Starship prompt, AWS SSO aliases, tmux project management
- **Starship**: Minimal prompt showing directory, git branch, and status
