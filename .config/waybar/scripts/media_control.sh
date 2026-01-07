#!/bin/bash

status=$(playerctl status 2>/dev/null)

# Hide when nothing is playing or paused
[ -z "$status" ] && exit 0

if [ "$status" = "Playing" ]; then
  icon="󰏤"   # pause icon
else
  icon="󰐊"   # play icon
fi

echo "{\"text\":\"$icon\"}"
