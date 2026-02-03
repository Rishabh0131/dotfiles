#!/bin/bash
# Not in use cuurently
nmcli -t -f IN-USE,SSID,SECURITY,SIGNAL dev wifi list |
    sed 's/^*/✓/' |
    rofi -dmenu -p "Wi-Fi" |
    awk '{print $1}' |
    xargs -r nmcli dev wifi connect
