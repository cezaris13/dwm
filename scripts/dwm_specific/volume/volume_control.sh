#!/bin/bash
volume_setting=$1

if [[ $volume_setting == "toggleSound" ]]
then
    default_sink=$(pactl info | grep "Default Sink:.*" | sed "s/Default Sink: //g")
    pactl set-sink-mute $default_sink toggle;
else
    bluetooth_headphones=$(sh $HOME/.config/dwm/scripts/dwm_specific/bluetooth/./find_bluetooth_headphones.sh )
    if [[ ! -z $bluetooth_headphones ]]
    then
        bluetooth_sink_name=$(pacmd list-sinks | grep --color=never name:.*$ | grep --color=never "^.*bluez.*$" | sed "s/.*<//g;s/>//g");
        bluetooth_volume=$(pactl get-sink-volume $bluetooth_sink_name | grep --color=never -o "front-right:.*" | grep -o "/.*/" | sed "s/\///g; s/ //g;s/%//g");
        volume_sign=$(echo $volume_setting | head -c 1);
        if [[ "$bluetooth_volume" -le "100" || "$volume_sign" == "-" ]]
        then
            pactl set-sink-volume $bluetooth_sink_name $volume_setting;
        fi
    else
        # this is needed to convert +5% to 5%+, since Amixer uses different format
        volume_setting+=$(echo $volume_setting | head -c 1)
        converted_volume_setting="${volume_setting:1}"
        amixer -q sset Master $converted_volume_setting;
    fi
fi
