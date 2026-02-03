#!/bin/bash

STATE_FILE="/tmp/waybar_media_scroll"

status=$(playerctl status 2>/dev/null)

# Hide only if stopped or no player
if [ -z "$status" ] || [ "$status" = "Stopped" ]; then
    rm -f "$STATE_FILE"
    exit 0
fi

artist=$(playerctl metadata artist 2>/dev/null)
title=$(playerctl metadata title 2>/dev/null)

[ -z "$artist" ] && [ -z "$title" ] && exit 0

text="$artist - $title"

# Config
MAX=30    # visible width
GAP=" | " # space between loops
SCROLL="$text$GAP"

# Reset scroll if track changes
LAST_TEXT_FILE="/tmp/waybar_media_last"
if [ "$(cat "$LAST_TEXT_FILE" 2>/dev/null)" != "$text" ]; then
    echo "$text" >"$LAST_TEXT_FILE"
    echo 0 >"$STATE_FILE"
fi

OFFSET=$(cat "$STATE_FILE" 2>/dev/null || echo 0)

LEN=${#SCROLL}

# Build visible window
VISIBLE="${SCROLL:$OFFSET:$MAX}"

# Wrap around
if [ ${#VISIBLE} -lt $MAX ]; then
    VISIBLE="$VISIBLE${SCROLL:0:$((MAX - ${#VISIBLE}))}"
fi

# Advance offset
OFFSET=$((OFFSET + 1))
[ "$OFFSET" -ge "$LEN" ] && OFFSET=0
echo "$OFFSET" >"$STATE_FILE"

# Output
if [ "$status" = "Paused" ]; then
    echo "{\"text\":\"$VISIBLE\",\"class\":\"paused\"}"
else
    echo "{\"text\":\"$VISIBLE\"}"
fi
