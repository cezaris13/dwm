#!/usr/bin/env bash
function set_lithuanian_support () {
    device_code=$(xinput list | grep "Keychron K4" | grep "keyboard" | awk '{print $5}' | grep -o "[0-9]*")
    setxkbmap -device "$device_code" -layout us,lt -option 'grp:alt_shift_toggle'
    notify-send "bluetooth keyboard now has lithuanian support"
}

set_lithuanian_support