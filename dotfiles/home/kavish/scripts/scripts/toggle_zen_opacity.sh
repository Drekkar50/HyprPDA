#!/bin/bash

STATE_FILE="/tmp/zen_opacity_state"
WINDOW_CLASS="zen"
RULE_PREFIX="opacity"

# Define rules
OPAQUE_RULE="$RULE_PREFIX 1.0 1.0,class:^(zen)$"
TRANSLUCENT_RULE="$RULE_PREFIX 0.9 0.75,class:^(zen)$"

# If translucent, switch to opaque
if [[ -f "$STATE_FILE" && "$(cat "$STATE_FILE")" == "translucent" ]]; then
    hyprctl keyword windowrulev2 remove "$TRANSLUCENT_RULE"
    hyprctl keyword windowrulev2 "$OPAQUE_RULE"
    echo "opaque" > "$STATE_FILE"
else
    hyprctl keyword windowrulev2 remove "$OPAQUE_RULE"
    hyprctl keyword windowrulev2 "$TRANSLUCENT_RULE"
    echo "translucent" > "$STATE_FILE"
fi

# Optionally force refresh by focusing away and back
# Replace "zen" with your terminal class if needed
hyprctl dispatch focuswindow "class:^(zen)$"

