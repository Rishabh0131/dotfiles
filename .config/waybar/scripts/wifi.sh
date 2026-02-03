#!/usr/bin/env bash
# Not in use cuurently
# Check active Wi-Fi
WIFI_INFO=$(nmcli -t -f DEVICE,TYPE,STATE dev status | grep ':wifi:connected')
ETH_INFO=$(nmcli -t -f DEVICE,TYPE,STATE dev status | grep ':ethernet:connected')

if [ -n "$WIFI_INFO" ]; then
    SSID=$(nmcli -t -f ACTIVE,SSID dev wifi | grep '^yes' | cut -d: -f2)
    SIGNAL=$(nmcli -t -f ACTIVE,SIGNAL dev wifi | grep '^yes' | cut -d: -f2)

    SIGNAL=${SIGNAL:-"?"}
    SSID=${SSID:-"Unknown"}

    echo "{\"text\":\"󰤨\",\"tooltip\":\"Wi-Fi: $SSID\nSignal: ${SIGNAL}%\"}"

elif [ -n "$ETH_INFO" ]; then
    echo "{\"text\":\"󰈀\",\"tooltip\":\"Wired connection\"}"

else
    echo "{\"text\":\"󰤭\",\"tooltip\":\"No network connection\"}"
fi
