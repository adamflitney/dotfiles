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

## Configs

- **Karabiner-Elements**: Maps shift+space to F12 (leader key), Caps Lock to Ctrl/Esc
- **Neovim**: LazyVim configuration
- **Tmux**: Terminal multiplexer configuration
- **LeaderKey**: F12 leader key shortcuts for app launching (t=Ghostty, b=browsers, r=Raycast, n=Obsidian)
