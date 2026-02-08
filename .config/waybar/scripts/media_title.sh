#!/bin/bash

PLAYER="spotify,%any"
STATE_FILE="/tmp/waybar_media_scroll"
LAST_TEXT_FILE="/tmp/waybar_media_last"

status=$(playerctl -p "$PLAYER" status 2>/dev/null)

# Hide if stopped or no player
if [ -z "$status" ] || [ "$status" = "Stopped" ]; then
    rm -f "$STATE_FILE" "$LAST_TEXT_FILE"
    exit 0
fi

artist=$(playerctl -p "$PLAYER" metadata artist 2>/dev/null)
title=$(playerctl -p "$PLAYER" metadata title 2>/dev/null)

[ -z "$artist" ] && [ -z "$title" ] && exit 0

text="$artist - $title"

# Scroll config
MAX=30
GAP=" | "
SCROLL="$text$GAP"

# Reset scroll if song changed
if [ "$(cat "$LAST_TEXT_FILE" 2>/dev/null)" != "$text" ]; then
    echo "$text" >"$LAST_TEXT_FILE"
    echo 0 >"$STATE_FILE"
fi

OFFSET=$(cat "$STATE_FILE" 2>/dev/null || echo 0)
LEN=${#SCROLL}

VISIBLE="${SCROLL:$OFFSET:$MAX}"

if [ ${#VISIBLE} -lt $MAX ]; then
    VISIBLE="$VISIBLE${SCROLL:0:$((MAX - ${#VISIBLE}))}"
fi

OFFSET=$((OFFSET + 1))
[ "$OFFSET" -ge "$LEN" ] && OFFSET=0
echo "$OFFSET" >"$STATE_FILE"

if [ "$status" = "Paused" ]; then
    echo "{\"text\":\"$VISIBLE\",\"class\":\"paused\"}"
else
    echo "{\"text\":\"$VISIBLE\"}"
fi
