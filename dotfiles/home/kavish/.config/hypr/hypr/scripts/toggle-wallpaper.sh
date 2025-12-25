#!/bin/bash

# File paths
videowallpaper="/home/kavish/wallpaper/mylivewallpapers.com-Kelp-Forest.mp4"
blackscreen="/home/kavish/Downloads/black-background.png"
state_file="/tmp/current_wallpaper"

# Always ensure hyprpaper is running and showing black
if ! pgrep -x hyprpaper > /dev/null; then
    hyprpaper &
    sleep 0.3
    hyprctl hyprpaper wallpaper "eDP-1,$blackscreen"
fi

# Read current state
if [ ! -f "$state_file" ]; then
    echo "black" > "$state_file"
    state="black"
else
    state=$(<"$state_file")
fi

# Toggle logic
if [ "$state" = "black" ]; then
    # Start video wallpaper
    mpvpaper eDP-1 "$videowallpaper" -- --loop --mute=yes & disown
    echo "video" > "$state_file"
else
    # Kill mpvpaper to reveal the black background underneath
    killall mpvpaper 2>/dev/null
    echo "black" > "$state_file"
fi

