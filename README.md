# Dotfiles

My configuration files for macOS.

## Setup

### Karabiner-Elements

```bash
ln -sf ~/dotfiles/karabiner/karabiner.json ~/.config/karabiner/karabiner.json
```

### Neovim

```bash
ln -sf ~/dotfiles/nvim ~/.config/nvim
```

### Tmux

```bash
ln -sf ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
```

### LeaderKey

```bash
ln -sf ~/dotfiles/leaderkey/config.json ~/Library/Application\ Support/Leader\ Key/config.json
```

### Tmuxinator (Project Templates)

```bash
ln -sf ~/dotfiles/tmuxinator ~/.config/tmuxinator
```

Add to your `~/.zshrc`:
```bash
source ~/dotfiles/zsh/tmux-aliases.zsh
```

See [TMUX_PROJECT_GUIDE.md](./TMUX_PROJECT_GUIDE.md) for complete usage guide.

## Configs

- **Karabiner-Elements**: Maps shift+space to F12 (leader key), Caps Lock to Ctrl/Esc
- **Neovim**: LazyVim configuration with persistence, telescope, and OpenCode integration
- **Tmux**: Terminal multiplexer with session persistence, vim navigation, and project management
- **Tmuxinator**: Project templates for quick workspace setup (neovim + OpenCode + terminal)
- **LeaderKey**: F12 leader key shortcuts for app launching (t=Ghostty, b=browsers, r=Raycast, n=Obsidian)
- **Zsh**: Shell aliases and functions for tmux project management
