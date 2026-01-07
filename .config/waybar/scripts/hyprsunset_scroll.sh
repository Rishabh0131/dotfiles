#!/usr/bin/env bash

CONF="$HOME/.config/hypr/hyprsunset.conf"

STEP_TEMP=200
MIN_TEMP=3000
MAX_TEMP=6500

TEMP=$(grep '^temperature=' "$CONF" | cut -d= -f2)
TEMP=${TEMP:-4500}

if [ "$1" = "up" ]; then
  TEMP=$((TEMP - STEP_TEMP))
elif [ "$1" = "down" ]; then
  TEMP=$((TEMP + STEP_TEMP))
fi

(( TEMP < MIN_TEMP )) && TEMP=$MIN_TEMP
(( TEMP > MAX_TEMP )) && TEMP=$MAX_TEMP

sed -i "s/^temperature=.*/temperature=$TEMP/" "$CONF"

# restart safely
if pgrep -x hyprsunset >/dev/null; then
  pkill -SIGINT hyprsunset
  sleep 0.25   # <-- CRITICAL
  hyprsunset -t "$TEMP" &
fi

