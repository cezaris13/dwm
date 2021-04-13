#!/usr/bin/env bash
DeviceCode=$(xinput list | grep "Keychron K4 Keyboard" | awk '{print $5}' | grep -o "[0-9]*")
setxkbmap -device "$DeviceCode" -layout us,lt -option 'grp:alt_shift_toggle'
notify-send "bluetooth keyboard now has lithuanian support"
