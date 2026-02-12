# Dotfiles

My configuration files for macOS, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Quick Setup

```bash
git clone https://github.com/adamflitney/dotfiles.git ~/dotfiles
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
| `zsh` | `~/.zshrc` | Shell config with Oh My Zsh, Starship prompt, and aliases |
| `scripts` | `~/.local/bin/` | Utility scripts (dotfiles-sync) |
| `starship` | `~/.config/starship.toml` | Minimal Starship prompt configuration |
| `sesh` | `~/.config/sesh/config.yaml` | Sesh configuration for tmux session management |

## Manual Installation

### Install Individual Packages

```bash
cd ~/dotfiles
stow nvim      # Neovim config
stow tmux      # Tmux config
stow zsh       # Zsh configuration
stow scripts   # dotfiles-sync script
stow starship  # Starship prompt
stow sesh      # Sesh config
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

### Sesh (tmux session manager)

```bash
brew install go
go install github.com/adamflitney/sesh@latest
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

## Tmux Session Management

[Sesh](https://github.com/adamflitney/sesh) auto-discovers git repositories in configured directories and creates tmux sessions with a standard layout:

- Window 1: neovim
- Window 2: opencode
- Window 3: zsh (shell)

| Command | Description |
|---------|-------------|
| `sesh` | Fuzzy-find and start/attach to a project session |
| `tms` | List active tmux sessions |
| `tma <name>` | Attach to a tmux session |
| `tmk <name>` | Kill a tmux session |

## Configs Overview

- **Karabiner-Elements**: Maps shift+space to F12 (leader key), Caps Lock to Ctrl/Esc
- **Neovim**: LazyVim configuration with persistence, telescope, and OpenCode integration
- **Tmux**: Terminal multiplexer with session persistence and vim navigation
- **Sesh**: Auto-discovers git repos in ~/Dev and creates tmux sessions
- **LeaderKey**: F12 leader key shortcuts for app launching (t=Ghostty, b=browsers, r=Raycast, n=Obsidian)
- **Zsh**: Oh My Zsh with Starship prompt, AWS SSO aliases
- **Starship**: Minimal prompt showing directory, git branch, and status
