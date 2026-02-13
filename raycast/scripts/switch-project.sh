#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Switch Project
# @raycast.mode silent
# @raycast.packageName Development

# Optional parameters:
# @raycast.icon 🚀
# @raycast.description Open sesh project picker in Ghostty

# Focus or open Ghostty
open -a Ghostty

# Wait for Ghostty to be ready
sleep 0.15

# Check if we're in tmux by looking at Ghostty's environment
# Send the tmux keybinding to open sesh popup (Ctrl+s Ctrl+j)
osascript <<EOF
tell application "System Events"
    tell process "Ghostty"
        -- Send Ctrl+s (tmux prefix)
        keystroke "s" using control down
        delay 0.05
        -- Send Ctrl+j (sesh popup)
        keystroke "j" using control down
    end tell
end tell
EOF
