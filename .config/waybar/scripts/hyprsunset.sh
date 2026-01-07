#!/usr/bin/env bash

CONF="$HOME/.config/hypr/hyprsunset.conf"

TEMP=$(grep '^temperature=' "$CONF" | cut -d= -f2)
GAMMA=$(grep '^gamma=' "$CONF" | cut -d= -f2)

TEMP=${TEMP:-4500}
GAMMA=${GAMMA:-1.0}

if pgrep -x hyprsunset >/dev/null; then
  echo "{\"text\":\"\",\"class\":\"on\",\"tooltip\":\"Night light ON\nTemp: ${TEMP}K\nGamma: ${GAMMA}\"}"
else
  echo "{\"text\":\"盛\",\"class\":\"off\",\"tooltip\":\"Night light OFF\"}"
fi

