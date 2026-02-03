#!/bin/bash

status=$(playerctl status 2>/dev/null)

# Hide widget if nothing is running or player is stopped
if [ -z "$status" ] || [ "$status" = "Stopped" ]; then
    exit 0
fi

if [ "$status" = "Playing" ]; then
    icon="󰏤" # pause icon
else
    icon="󰐊" # play icon
fi

echo "{\"text\":\"$icon\"}"
