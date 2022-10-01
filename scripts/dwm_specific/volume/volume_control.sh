#!/bin/bash

function set_volume(){
    volume_setting=$1
    quiet=$2

    if [[ $volume_setting == "toggleSound" ]]
    then
        default_sink=$(pactl info | grep "Default Sink:.*" | sed "s/Default Sink: //g")
        pactl set-sink-mute $default_sink toggle;
        send_volume_notification -q
    else
        bluetooth_headphones=$(sh $HOME/.config/dwm/scripts/dwm_specific/bluetooth/./bluetooth.sh get_headphone_name )
        if [[ ! -z $bluetooth_headphones ]]
        then
            bluetooth_sink_name=$(pacmd list-sinks | grep --color=never name:.*$ | grep --color=never "^.*bluez.*$" | sed "s/.*<//g;s/>//g");
            bluetooth_volume=$(pactl get-sink-volume $bluetooth_sink_name | grep --color=never -o "front-right:.*" | grep -o "/.*/" | sed "s/\///g; s/ //g;s/%//g");
            volume_sign=$(echo $volume_setting | head -c 1);
            if [[ "$bluetooth_volume" -le "100" || "$volume_sign" == "-" ]]
            then
                pactl set-sink-volume $bluetooth_sink_name $volume_setting;
                send_volume_notification $quiet
            fi
        else
            # this is needed to convert +5% to 5%+, since Amixer uses different format
            volume_setting+=$(echo $volume_setting | head -c 1)
            converted_volume_setting="${volume_setting:1}"
            amixer -q sset Master $converted_volume_setting;
            send_volume_notification $quiet
        fi
    fi
}

function send_volume_notification(){
    quiet=$1
    percentage=$(get_volume_percentage)
    percentage=$(fix_volume_percentage $percentage)
    kill -44 $(pidof dwmblocks)
    if [[ $quiet != "-q" ]]
    then
        notify-send --hint=string:x-dunst-stack-tag:volume "volume $percentage"
    fi
}

function fix_volume_percentage(){
    parsed_percentage=$(echo $1 | grep -o "[0-9]*")
    if [[ "$parsed_percentage" -gt "100" ]]
    then
        echo "[100%]"
        return 0
    fi
    echo $1
}

function get_volume_percentage() {
    bluetooth_headphones=$(sh $HOME/.config/dwm/scripts/dwm_specific/bluetooth//./bluetooth.sh get_headphone_name  )
    if [[ ! -z $bluetooth_headphones ]]
    then
        bluetooth_sink_mame=$(pacmd list-sinks | grep --color=never name:.*$ | grep --color=never "^.*bluez.*$" | sed "s/.*<//g;s/>//g");
        pactl get-sink-volume $bluetooth_sink_mame | grep --color=never -o "front-right:.*" | grep -o "/.*/" | sed "s/\///g; s/ //g" | sed -e "s/\(.*\)/[\1]/";
    else
        amixer get Master | awk '/Mono.+/ {print $6=="[off]"?$6:$4}';
    fi
}

case "$1" in
    "") ;;
    set_volume) "$@" $2 $3; exit;;
    get_volume_percentage) "$@"; exit;;
    fix_volume_percentage) "$@" $2; exit;;
    *) echo "unknown command"; exit 2;;
esac
