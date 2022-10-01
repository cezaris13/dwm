#!/bin/bash

function set_screen_brightness() {
    option=$1
    quiet=$2
    brightness_sign=$(echo $option | head -c 1);
    value="${option:1}"
    if [[ "$brightness_sign" == "+" ]]
    then
        xbacklight -inc $value
    else
        xbacklight -dec $value
    fi
    if [ -z $quiet ]
    then
        notify-send --hint=string:x-dunst-stack-tag:brightness "brightness: $(printf "%.0f\n" $(xbacklight -get)) %"
    fi
}

set_screen_brightness $1 $2
