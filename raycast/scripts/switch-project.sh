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
CLIENT=$(tmux list-clients -F '#{client_tty}' 2>/dev/null | head -1)

if [ -n "$CLIENT" ]; then
    # Tmux client exists - focus Ghostty and show popup
    open -a Ghostty
    sleep 0.1
    tmux display-popup -t "$CLIENT" -E -w 80% -h 70% "$SESH"
else
    # No tmux client - open Ghostty (which will auto-start tmux via config)
    # Then wait for the client to appear and show popup
    open -a Ghostty
    
    # Wait for tmux client to be ready (up to 2 seconds)
    for i in {1..20}; do
        sleep 0.1
        CLIENT=$(tmux list-clients -F '#{client_tty}' 2>/dev/null | head -1)
        if [ -n "$CLIENT" ]; then
            sleep 0.2  # Extra delay for stability
            tmux display-popup -t "$CLIENT" -E -w 80% -h 70% "$SESH"
            exit 0
        fi
    done
    
    # Fallback: if we still can't get a client, just open Ghostty
    # User can manually run sesh
fi
