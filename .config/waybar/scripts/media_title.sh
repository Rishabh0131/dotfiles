#!/bin/bash

status=$(playerctl status 2>/dev/null)
[ "$status" != "Playing" ] && exit 0

artist=$(playerctl metadata artist)
title=$(playerctl metadata title)

full="$artist - $title"
max=28

if [ ${#full} -gt $max ]; then
  text="${full:0:$max}…"
else
  text="$full"
fi

echo "{\"text\":\"$text\"}"

