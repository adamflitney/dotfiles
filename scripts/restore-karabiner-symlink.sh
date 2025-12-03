#!/bin/bash

# Script to restore Karabiner symlink if it gets overwritten

KARABINER_CONFIG="$HOME/.config/karabiner/karabiner.json"
DOTFILES_CONFIG="$HOME/dotfiles/karabiner/karabiner.json"

# Check if current file is a symlink
if [ ! -L "$KARABINER_CONFIG" ]; then
    echo "Karabiner config is not a symlink, restoring..." >&2
    
    # Backup current config
    cp "$KARABINER_CONFIG" "$KARABINER_CONFIG.backup.$(date +%s)"
    
    # Remove current file and create symlink
    rm "$KARABINER_CONFIG"
    ln -s "$DOTFILES_CONFIG" "$KARABINER_CONFIG"
    
    echo "Symlink restored. Restart Karabiner Elements." >&2
fi