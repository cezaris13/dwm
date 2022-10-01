#!/usr/bin/env bash
function get_volume_percentage() {
    bluetooth_headphones=$(sh $HOME/.config/dwm/scripts/dwm_specific/bluetooth//./find_bluetooth_headphones.sh )
    if [[ ! -z $bluetooth_headphones ]]
    then
        bluetooth_sink_mame=$(pacmd list-sinks | grep --color=never name:.*$ | grep --color=never "^.*bluez.*$" | sed "s/.*<//g;s/>//g");
        pactl get-sink-volume $bluetooth_sink_mame | grep --color=never -o "front-right:.*" | grep -o "/.*/" | sed "s/\///g; s/ //g" | sed -e "s/\(.*\)/[\1]/";
    else
        amixer get Master | awk '/Mono.+/ {print $6=="[off]"?$6:$4}';
    fi
}

get_volume_percentage
