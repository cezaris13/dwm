#!/bin/bash
volumeSetting=$1

if [[ $volumeSetting == "toggleSound" ]]
then
    defaultSink=$(pactl info | grep "Default Sink:.*" | sed "s/Default Sink: //g")
    pactl set-sink-mute $defaultSink toggle;
else
    bluetoothHeadphones=$(sh $HOME/.config/dwm/scripts/dwm_specific/bluetooth/./find_bluetooth_headphones.sh )
    if [[ ! -z $bluetoothHeadphones ]]
    then
        bluetoothSinkName=$(pacmd list-sinks | grep --color=never name:.*$ | grep --color=never "^.*bluez.*$" | sed "s/.*<//g;s/>//g");
        pactl set-sink-volume $bluetoothSinkName $volumeSetting;
    else
        # this is needed to convert +5% to 5%+, since Amixer uses different format
        volumeSetting+=$(echo $volumeSetting | head -c 1)
        convertedVolumeSetting="${volumeSetting:1}"
        amixer -q sset Master $convertedVolumeSetting;
    fi
fi
