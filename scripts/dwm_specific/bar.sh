#!/bin/bash
val=$1
if [[ ! -z $2 ]]
then 
	BLOCK_BUTTON=$2
fi
function module {
	case $val in
		"battery") (cd $HOME/.config/dwm/scripts/dwm_specific/bluetooth; battery_utils);;
		"volume") (cd $HOME/.config/dwm/scripts/dwm_specific/volume; volume_utils);;
		"network") network_utils;;
		"date") calendar_utils;;
		"layout") layout_utils;;
		"lock_keys") lock_key_utils;;
	esac
}

function volume_utils() {
	case $BLOCK_BUTTON in
		1) xterm -e alsamixer;;
		2) $(sh ./volume_control.sh set_volume toggleSound);;
#		3) notify-send "Volume module" "\- Shows volume, [off] if muted.
#-Left click to open alsamixer
#- Middle click to mute.
#- Scroll to change." ;;
		3) SonyHeadphonesClient ;;
		4) $(sh ./volume_control.sh set_volume +5% -q);;
		5) $(sh ./volume_control.sh set_volume -5% -q);;
	esac
	percentage=$(sh ./volume_control.sh get_volume_percentage)
	percentage=$(sh ./volume_control.sh fix_volume_percentage $percentage)
	echo -n "VOL $percentage "
}

function battery_utils() {
	bluetooth_headphones=$(sh ./bluetooth.sh get_headphone_name)
	bluetooth_headphones_percentage=$(pacmd list-sinks | grep "bluetooth.battery.*$" | sed "s/\s//g; s/bluetooth\.battery=\"//g;s/\"//g")
	case $BLOCK_BUTTON in
		1) notify-send "$(echo $(upower -d | grep 'time to empty' | sort -u ))";;
		2) notify-send "mouse battery $(upower -d | grep "percentage" | awk '/ignored/{ print $1 $2}' | grep -m 1 "percentage")
		   		$([[ ! -z "$bluetooth_headphones" ]] && echo "$bluetooth_headphones battery: $bluetooth_headphone_percentage")";;
		3) notify-send "Battery module" "\-left click to show time to empty";;
# add keychron battery status
	esac
	charging="$(cat /sys/class/power_supply/AC0/online)"
	[ $charging -eq 1 ] && echo -n "    charging " || echo -n " discharging "
	echo -n $(cat /sys/class/power_supply/BAT0/capacity)"% "
}

function network_utils() {
	case $BLOCK_BUTTON in
		1) pkill -RTMIN+4 dwmblocks;;
		2) xterm -e nmtui;;
		3) notify-send "Internet module" "\- Click to connect
down: no wifi connection
ip adress: wifi connection with quality
-middle click: open nmtui";;
	esac
	ip="$(ip addr show | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -v '.*255\S*$\|127.0.0.1\S*$')"
	case "$(cat /sys/class/net/w*/operstate 2>/dev/null)" in
		down) echo -n 'down ';;
		up) echo "${ip%%/*} "
	esac
}

function calendar_utils() {
	case $BLOCK_BUTTON in
		1) notify-send "This Month" "$(cal --color=always -m | sed "s/..7m/<b><span color=\"red\">/;s/..27m/<\/span><\/b>/")" ;;
		3) notify-send "Time/date module" "\- Left click to show the month via \`cal\`" ;;
	esac
	echo "$(date +"%Y:%m:%d %H:%M:%S") "
}

function layout_utils() {
	[ $(xkblayout) == "Lit" ] && echo -n " LT " || echo -n " US "
}

function lock_key_utils() {
	caps="$(xset -q | awk '/Caps/ {print $4}')"
	num="$(xset -q | awk '/Caps/ {print $8}')"
    [ $caps == "on" ] && echo -n "CAPS | " || echo -n "     | "
    [ $num == "on" ] && echo -n "NUM " || echo -n "    "
}

module $val
