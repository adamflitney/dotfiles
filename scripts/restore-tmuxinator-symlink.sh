#!/bin/bash
# Script to restore tmuxinator symlink if it gets overwritten

TMUXINATOR_CONFIG="$HOME/.config/tmuxinator"
DOTFILES_CONFIG="$HOME/dotfiles/tmuxinator"

# Check if current directory is a symlink
if [ ! -L "$TMUXINATOR_CONFIG" ]; then
    echo "Tmuxinator config is not a symlink, restoring..." >&2
    
    # Backup current config if it exists and has files
    if [ -d "$TMUXINATOR_CONFIG" ] && [ "$(ls -A $TMUXINATOR_CONFIG)" ]; then
        backup_dir="$TMUXINATOR_CONFIG.backup.$(date +%s)"
        mv "$TMUXINATOR_CONFIG" "$backup_dir"
        echo "Backed up existing config to $backup_dir" >&2
    fi
    
    # Remove current directory and create symlink
    rm -rf "$TMUXINATOR_CONFIG"
    ln -s "$DOTFILES_CONFIG" "$TMUXINATOR_CONFIG"
    
    echo "Symlink restored." >&2
fi
