#!/bin/bash

TIMER_FILE="/tmp/waybar_timer.json"
NOTIFY_FILE="/tmp/waybar_timer_notify"
BAR_LENGTH=40 # Length of the bar in characters

if [[ ! -f $TIMER_FILE ]]; then
    echo '{"text":"󰔛", "tooltip":"No timer set", "class":"timer-idle"}'
    rm -f "$NOTIFY_FILE"
    exit
fi

data=$(cat "$TIMER_FILE")
end_time=$(jq -r '.end_time' <<< "$data")
start_time=$(jq -r '.start_time' <<< "$data")
now=$(date +%s)

total=$((end_time - start_time))
remaining=$((end_time - now))

if (( remaining <= 0 )); then
    if [[ ! -f $NOTIFY_FILE ]]; then
        notify-send "⏰ Time's up!" "Your Waybar timer has ended."
        touch "$NOTIFY_FILE"
    fi
    echo '{"text":"󰔛 Done!", "tooltip":"Timer done!", "class":"timer-done"}'
else
    percent=$((100 * (total - remaining) / total))
    filled=$((BAR_LENGTH * percent / 100))
    empty=$((BAR_LENGTH - filled))

    bar="$(printf '█%.0s' $(seq 1 $filled))"
    bar+=$(printf '░%.0s' $(seq 1 $empty))

    min=$((remaining / 60))
    sec=$((remaining % 60))
    echo "{\"text\":\"$bar ${min}m ${sec}s\", \"tooltip\":\"Time remaining: ${min}m ${sec}s\", \"class\":\"timer-running\"}"
    rm -f "$NOTIFY_FILE"
fi

