#!/bin/bash

PLAYER="spotify,%any"

status=$(playerctl -p "$PLAYER" status 2>/dev/null)

# Hide widget if nothing is running or stopped
if [ -z "$status" ] || [ "$status" = "Stopped" ]; then
    exit 0
fi

if [ "$status" = "Playing" ]; then
    icon="󰏤" # pause
else
    icon="󰐊" # play
fi

echo "{\"text\":\"$icon\"}"
