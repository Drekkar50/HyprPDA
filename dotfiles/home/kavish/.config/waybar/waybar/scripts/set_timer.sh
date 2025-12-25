#!/bin/bash

# Set a timer for N minutes
MINUTES=$1
END_TIME=$(( $(date +%s) + MINUTES * 60 ))

echo "{\"end_time\": $END_TIME}" > /tmp/waybar_timer.json

