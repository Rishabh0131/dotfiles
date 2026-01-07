#!/usr/bin/env bash


CONF="$HOME/.config/hypr/hyprsunset.conf"

TEMP=$(grep '^temperature=' "$CONF" | cut -d= -f2)
GAMMA=$(grep '^gamma=' "$CONF" | cut -d= -f2)

TEMP=${TEMP:-4500}
GAMMA=${GAMMA:-1.0}

if pgrep -x hyprsunset >/dev/null; then
  pkill hyprsunset
else
  hyprsunset -t "$TEMP" --gamma "$(awk "BEGIN {print int($GAMMA * 100)}")" &
fi

