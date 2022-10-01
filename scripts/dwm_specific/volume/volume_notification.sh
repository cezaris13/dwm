#!/bin/sh
function send_volume_notification(){
    percentage=$($HOME/.config/dwm/scripts/dwm_specific/volume/./volume_percentage.sh)
    parsed_percentage=$(echo $percentage | grep -o "[0-9]*")
    if [[ "$parsed_percentage" -gt "100" ]]
    then
        percentage="[100%]"
    fi
    kill -44 $(pidof dwmblocks) && notify-send --hint=string:x-dunst-stack-tag:volume "volume $percentage"
}

send_volume_notification
