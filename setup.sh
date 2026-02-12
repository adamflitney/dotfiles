#!/bin/bash
# setup.sh - Set up dotfiles on a new machine
set -e

DOTFILES_DIR="$HOME/dotfiles"
cd "$DOTFILES_DIR"

echo "==> Setting up dotfiles with stow..."

# Check for stow
if ! command -v stow &> /dev/null; then
  echo "Installing stow via Homebrew..."
  brew install stow
fi

# Create directories that stow expects to exist
mkdir -p ~/.config
mkdir -p ~/.local/bin
mkdir -p ~/.local/share
mkdir -p ~/.zsh

# Remove existing configs that would conflict
echo "==> Removing existing configs (if any)..."
rm -rf ~/.config/nvim 2>/dev/null || true
rm -f ~/.tmux.conf 2>/dev/null || true
rm -rf ~/.config/tmuxinator 2>/dev/null || true
rm -f ~/.zshrc 2>/dev/null || true
rm -rf ~/.zsh 2>/dev/null || true
rm -f ~/.config/starship.toml 2>/dev/null || true

# Stow all packages
echo "==> Stowing packages..."
stow nvim
stow tmux
stow tmuxinator
stow zsh
stow scripts
stow starship

echo "==> Setting up dotfiles auto-sync..."

# Ensure LaunchAgents directory exists
mkdir -p ~/Library/LaunchAgents

# Copy LaunchAgent plist (substitute username for portability)
sed "s|/Users/adamflitney|$HOME|g" \
  "$DOTFILES_DIR/launchagents/com.adamflitney.dotfiles-sync.plist" \
  > ~/Library/LaunchAgents/com.adamflitney.dotfiles-sync.plist

# Load the LaunchAgent
launchctl unload ~/Library/LaunchAgents/com.adamflitney.dotfiles-sync.plist 2>/dev/null || true
launchctl load ~/Library/LaunchAgents/com.adamflitney.dotfiles-sync.plist

echo ""
echo "==> Dotfiles installed successfully!"
echo ""
echo "Packages installed:"
echo "  - nvim       -> ~/.config/nvim"
echo "  - tmux       -> ~/.tmux.conf"
echo "  - tmuxinator -> ~/.config/tmuxinator"
echo "  - zsh        -> ~/.zshrc, ~/.zsh/"
echo "  - scripts    -> ~/.local/bin/tm, tmn, dotfiles-sync"
echo "  - starship   -> ~/.config/starship.toml"
echo ""
echo "Auto-sync enabled (hourly). Check logs: tail ~/.local/share/dotfiles-sync.log"
echo ""
echo "Manual setup still required:"
echo "  - Karabiner: ln -sf ~/dotfiles/karabiner/karabiner.json ~/.config/karabiner/karabiner.json"
echo "  - LeaderKey: ln -sf ~/dotfiles/leaderkey/config.json ~/Library/Application\\ Support/Leader\\ Key/config.json"
echo ""
echo "Restart your terminal or run: source ~/.zshrc"
