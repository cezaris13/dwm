#!/bin/bash

function set_screen_brightness() {
    option=$1
    quiet=$2
    brightness_sign=$(echo $option | head -c 1)
    value="${option:1}"
    if [[ "$brightness_sign" == "+" ]]; then
        xbacklight -inc $value
    else
        xbacklight -dec $value
    fi

    if [ -z $quiet ]; then
        send_notification
    fi
}

function send_notification() {
    brightness_notification_flag=$(cat $HOME/.config/dwm/configs/flags | grep "NEW_BRIGHTNESS_NOTIFICATIONS" | grep -o "[0-9]*")
    if [[ ! -z $brightness_notification_flag && $brightness_notification_flag -eq 1 ]]; then
        percents=$(printf "%.0f\n" $(xbacklight -get))
        volnoti-show -b $percents
    else
        notify-send --hint=string:x-dunst-stack-tag:brightness "brightness: $(printf "%.0f\n" $(xbacklight -get)) %"
    fi

}

set_screen_brightness $1 $2
