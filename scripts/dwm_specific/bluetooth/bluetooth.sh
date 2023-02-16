#!/bin/bash

function connect_headphones() {
	command=$($HOME/.config/dwm/scripts/shared/./dmenu_replacement.sh 2 bluetooth_data.txt 10 "Sony_headphones")

	earbuds="30:53:C1:6E:9D:DB"

	#bluetoothctl pair $earbuds

	if [[ "$(echo $command)" == "connect" ]]; then
		bluetoothctl connect $earbuds
	elif [[ "$(echo $command)" == "disconnect" ]]; then
		bluetoothctl disconnect $earbuds
	fi

}

function get_headphone_name() {
	pacmd list-sinks | grep "bluez\.alias.*$" | sed "s/\s//g; s/bluez\.alias=\"//g;s/\"//g"
}

case "$1" in
    "") ;;
    connect_headphones) "$@"; exit;;
    get_headphone_name) "$@"; exit;;
    *) echo "unknown command"; exit 2;;
esac
