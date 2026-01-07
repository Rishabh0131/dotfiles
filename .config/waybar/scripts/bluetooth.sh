#!/bin/bash

# Check if Bluetooth is powered on
POWER=$(bluetoothctl show 2>/dev/null | awk '/Powered/ {print $2}')

if [ "$POWER" != "yes" ]; then
  echo '{"text":"󰂲","tooltip":"Bluetooth is off"}'
  exit 0
fi

# Get info about the currently connected device
DEVICE_INFO=$(bluetoothctl info 2>/dev/null)

# If no device is connected
if ! echo "$DEVICE_INFO" | grep -q "Connected: yes"; then
  echo '{"text":"󰂲","tooltip":"Bluetooth on\nNo device connected"}'
  exit 0
fi

# Extract device name
NAME=$(echo "$DEVICE_INFO" | awk -F': ' '/Name/ {print $2}')

# Battery comes as: Battery: 0x64 (100)
BATT=$(echo "$DEVICE_INFO" | awk -F'[()]' '/Battery/ {print $2}')
BATT=${BATT:-"N/A"}

# Output JSON for Waybar
echo "{\"text\":\"󰂯\",\"tooltip\":\"Device: $NAME\nBattery: ${BATT}%\"}"

