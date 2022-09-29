#!/usr/bin/env bash
bluetoothHeadphones=$(sh $HOME/.config/dwm/scripts/dwm_specific/bluetooth//./find_bluetooth_headphones.sh )
if [[ ! -z $bluetoothHeadphones ]]
then
    bluetoothSinkName=$(pacmd list-sinks | grep --color=never name:.*$ | grep --color=never "^.*bluez.*$" | sed "s/.*<//g;s/>//g");
    pactl get-sink-volume $bluetoothSinkName | grep --color=never -o "front-right:.*" | grep -o "/.*/" | sed "s/\///g; s/ //g" | sed -e "s/\(.*\)/[\1]/";
else
    amixer get Master | awk '/Mono.+/ {print $6=="[off]"?$6:$4}';
fi
