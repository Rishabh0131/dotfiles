#!/bin/bash

SSID=$(nmcli -t -f ACTIVE,SSID dev wifi 2>/dev/null | grep '^yes' | cut -d: -f2)
SIGNAL=$(nmcli -t -f ACTIVE,SIGNAL dev wifi 2>/dev/null | grep '^yes' | cut -d: -f2)
IP=$(ip -4 addr show | awk '/inet / && !/127.0.0.1/ {print $2; exit}' | cut -d/ -f1)

if [ -z "$SSID" ]; then
  echo '{"text":"󰤭","tooltip":"Wi-Fi disconnected"}'
else
  SIGNAL=${SIGNAL:-"?"}
  IP=${IP:-"N/A"}

  echo "{\"text\":\"󰤨\",\"tooltip\":\"SSID: $SSID\nSignal: ${SIGNAL}%\nIP: $IP\"}"
fi


