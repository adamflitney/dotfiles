#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Quick Switch Session
# @raycast.mode silent
# @raycast.packageName Development

# Optional parameters:
# @raycast.icon ⚡
# @raycast.description Quick switch between active tmux sessions

# Focus or open Ghostty
open -a Ghostty

# Wait for Ghostty to be ready
sleep 0.15

# Send the tmux keybinding to open sesh switch popup (Ctrl+s Ctrl+k)
osascript <<EOF
tell application "System Events"
    tell process "Ghostty"
        -- Send Ctrl+s (tmux prefix)
        keystroke "s" using control down
        delay 0.05
        -- Send Ctrl+k (sesh switch - active sessions only)
        keystroke "k" using control down
    end tell
end tell
EOF
