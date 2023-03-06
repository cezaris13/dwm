#!/bin/bash
DIRECTORY=$HOME/.cache/NetworkStript
FILE=$HOME/.cache/NetworkStript/network_status.txt
online_icon=$HOME/.config/dwm/configs/tvolnoti/wifi_on.svg
offline_icon=$HOME/.config/dwm/configs/tvolnoti/wifi_off.svg

function check_for_connectivity() {
    if [[ ! -e $DIRECTORY ]]; then
        mkdir $DIRECTORY
    fi

    if [ ! -f $FILE ]; then
        touch $FILE
    fi

    while :
    do
    pingtime=$(ping -w 1 8.8.8.8 | grep ttl)
    if [ "$pingtime" = "" ]
    then
        pingtimetwo=$(ping -w 1 www.google.com | grep ttl)
        if [ "$pingtimetwo" = "" ]
        then
            notify_network_status "Offline"
        else
            notify_network_status "Online"
        fi
    else
        notify_network_status "Online"
    fi
    sleep 1
    done
}

function notify_network_status () {
    if [[ "$(cat $FILE)" != "$1" ]]; then
        echo "$1" > $FILE
        if [[ "$1" == "Online" ]]; then
            notification $online_icon $1
        else
            notification $offline_icon $1
        fi
    fi
}

function notification() {
    network_notification_flag=$(cat $HOME/.config/dwm/configs/flags | grep "NEW_NETWORK_NOTIFICATIONS" | grep -o "[0-9]*")
    if [[ ! -z $network_notification_flag && $network_notification_flag -eq 1 ]]; then
        tvolnoti-show -n -w -m -0 $1
    else
        notify-send --hint=string:x-dunst-stack-tag:volume "network $2"
    fi
}


check_for_connectivity
