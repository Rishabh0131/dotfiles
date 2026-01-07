#!/bin/bash

vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)

if echo "$vol" | grep -q MUTED; then
  echo "󰝟 Muted"
else
  percent=$(echo "$vol" | awk '{printf "%d", $2 * 100}')
  echo "󰕾 ${percent}%"
fi
