#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Switch Project
# @raycast.mode silent
# @raycast.packageName Development

# Optional parameters:
# @raycast.icon 🚀
# @raycast.description Open sesh project picker in Ghostty

SESH="/Users/adamflitney/go/bin/sesh"

# Check if tmux has any connected clients
CLIENT=$(/opt/homebrew/bin/tmux list-clients -F '#{client_tty}' 2>/dev/null | head -1)

if [ -n "$CLIENT" ]; then
    # Tmux client exists - focus Ghostty and show popup
    open -a Ghostty
    sleep 0.1
    # Pass the client TTY and ensure PATH includes homebrew
    /opt/homebrew/bin/tmux display-popup -t "$CLIENT" -E -w 80% -h 70% \
        "export PATH=/opt/homebrew/bin:\$PATH; export SESH_TARGET_CLIENT='$CLIENT'; $SESH"
else
    # No tmux client - open Ghostty (which will auto-start tmux via config)
    open -a Ghostty
    
    # Wait for tmux client to be ready (up to 2 seconds)
    for i in {1..20}; do
        sleep 0.1
        CLIENT=$(/opt/homebrew/bin/tmux list-clients -F '#{client_tty}' 2>/dev/null | head -1)
        if [ -n "$CLIENT" ]; then
            sleep 0.2
            /opt/homebrew/bin/tmux display-popup -t "$CLIENT" -E -w 80% -h 70% \
                "export PATH=/opt/homebrew/bin:\$PATH; export SESH_TARGET_CLIENT='$CLIENT'; $SESH"
            exit 0
        fi
    done
fi
