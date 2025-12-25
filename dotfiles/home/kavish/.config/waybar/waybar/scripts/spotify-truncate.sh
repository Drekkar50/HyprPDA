#!/bin/bash

track=$(playerctl metadata --format '{{artist}} - {{title}}')

# Truncate if too long
max_length=30
if [ ${#track} -gt $max_length ]; then
    echo "${track:0:$max_length}…"
else
    echo "$track"
fi

