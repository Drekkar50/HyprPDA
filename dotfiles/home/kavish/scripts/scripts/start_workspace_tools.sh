#!/bin/bash

# Get list of all current workspaces in use (those with windows)
used_workspaces=$(hyprctl clients -j | jq '.[].workspace.id' | sort -n | uniq)

# Set the max number of workspaces to check (e.g., 1 to 20)
max_workspace=20

# Find the first unused workspace
for i in $(seq 1 $max_workspace); do
    if ! echo "$used_workspaces" | grep -q "^$i$"; then
        workspace_num=$i
        break
    fi
done

# Fallback if all workspaces are full
if [ -z "$workspace_num" ]; then
    echo "No free workspace found. Defaulting to workspace 1."
    workspace_num=1
fi

# Switch to the chosen workspace
hyprctl dispatch workspace "$workspace_num"

# Wait for switch
sleep 0.2

# Launch apps
/home/kavish/.config/hypr/scripts/toggle-wallpaper.sh
~/.local/bin/Obsidian-1.8.10.AppImage &
okular &
firefox --new-window &

