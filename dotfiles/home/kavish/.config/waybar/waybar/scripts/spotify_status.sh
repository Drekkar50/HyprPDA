#!/bin/bash

artist=$(playerctl metadata artist 2>/dev/null)
title=$(playerctl metadata title 2>/dev/null)
status=$(playerctl status 2>/dev/null)

# Choose icon based on playback status
if [[ "$status" == "Playing" ]]; then
    icon=" \u00a0"  # play icon
    css_class="spotify-playing"
elif [[ "$status" == "Paused" ]]; then
    icon=""  # pause icon
    css_class="spotify-paused"
else
    icon=""  # stop icon
    css_class="spotify-stopped"
fi

# Construct and print JSON
if [[ -n "$artist" && -n "$title" ]]; then
    text="$icon $artist - $title"
else
    text="$icon No music playing"
fi

# Limit length if needed
MAXLEN=15

if [ ${#text} -gt $MAXLEN ]; then
    text="${text:0:$MAXLEN}…"
fi

echo "{\"text\": \"$text\", \"class\": \"$css_class\"}"

