#!/bin/bash

TIMER_FILE="/tmp/waybar_timer.json"

CHOICE=$(rofi -dmenu -p "Timer" -lines 5 <<EOF
5 min
10 min
15 min
30 min
45 min
60 min
120 min
Cancel Timer
EOF
)

case "$CHOICE" in
  "5 min") MINUTES=5 ;;
  "10 min") MINUTES=10 ;;
  "15 min") MINUTES=15 ;;
  "30 min") MINUTES=30 ;;
  "45 min") MINUTES=45 ;;
  "60 min") MINUTES=60 ;;
  "120 min") MINUTES=120 ;;
  "Cancel Timer")
    rm -f "$TIMER_FILE"
    notify-send "⏳ Timer cancelled"
    exit 0
    ;;
  *) exit 1 ;;
esac

START_TIME=$(date +%s)
END_TIME=$(( START_TIME + MINUTES * 60 ))
echo "{\"start_time\": $START_TIME, \"end_time\": $END_TIME}" > /tmp/waybar_timer.json

notify-send "⏳ Timer set for $MINUTES minutes"

