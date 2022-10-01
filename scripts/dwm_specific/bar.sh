#!/bin/bash
val=$1
if [[ ! -z $2 ]]
then 
	BLOCK_BUTTON=$2
fi
function module {
	if [[ $val == "battery" ]]
	then 
		bluetoothHeadphones=$(pacmd list-sinks | grep "bluez\.alias.*$" | sed "s/\s//g; s/bluez\.alias=\"//g;s/\"//g")
		bluetoothHeadphonesPercentage=$(pacmd list-sinks | grep "bluetooth.battery.*$" | sed "s/\s//g; s/bluetooth\.battery=\"//g;s/\"//g")
	   	case $BLOCK_BUTTON in
			1) notify-send "$(echo $(upower -d | grep 'time to empty' | sort -u ))";;
			2) notify-send "mouse battery $(upower -d | grep "percentage" | awk '/ignored/{ print $1 $2}' | grep -m 1 "percentage")
				$([[ ! -z "$bluetoothHeadphones" ]] && echo "$bluetoothHeadphones battery: $bluetoothHeadphonesStatus")";;
			3) notify-send "Battery module" "\-left click to show time to empty";;
# add keychron battery status
		esac
		charging="$(cat /sys/class/power_supply/AC0/online)"
		[ $charging -eq 1 ] && echo -n "    charging " || echo -n " discharging "
		echo -n $(cat /sys/class/power_supply/BAT0/capacity)"% "
	elif [[ $val == "volume" ]]
	then 
		case $BLOCK_BUTTON in
			1) xterm -e alsamixer;;
			2) $(sh $HOME/.config/dwm/scripts/dwm_specific/volume/./volume_control.sh toggleSound);;
#			3) notify-send "Volume module" "\- Shows volume, [off] if muted.
#-Left click to open alsamixer
#- Middle click to mute.
#- Scroll to change." ;;
			3) SonyHeadphonesClient ;;
			4) $(sh $HOME/.config/dwm/scripts/dwm_specific/volume/./volume_control.sh +5%);;
			5) $(sh $HOME/.config/dwm/scripts/dwm_specific/volume/./volume_control.sh -5%);;
		esac
		percentage=$($HOME/.config/dwm/scripts/dwm_specific/volume/./volume_percentage.sh)
		parsed_percentage=$(echo $percentage | grep -o "[0-9]*")
		if [[ "$parsed_percentage" -gt "100" ]]
		then
			percentage="[100%]"
		fi
		echo -n "VOL $percentage "
	elif [[ $val == "network" ]]
	then 
		case $BLOCK_BUTTON in
			1) pkill -RTMIN+4 dwmblocks;;
			2) xterm -e nmtui;;
			3) notify-send "Internet module" "\- Click to connect
down: no wifi connection
ip adress: wifi connection with quality
-middle click: open nmtui";;
		esac
		ip="$(ip addr show | awk '/192/ {print$2}')"
		case "$(cat /sys/class/net/w*/operstate 2>/dev/null)" in
			down) echo -n 'down ';;
			up) echo "${ip%%/*} "
		esac
	elif [[ $val == "date" ]]
	then 
		case $BLOCK_BUTTON in
			1) notify-send "This Month" "$(cal --color=always -m | sed "s/..7m/<b><span color=\"red\">/;s/..27m/<\/span><\/b>/")" ;;
			3) notify-send "Time/date module" "\- Left click to show the month via \`cal\`" ;;
		esac
		echo "$(date +"%Y:%m:%d %H:%M:%S") "
	elif [[ $val == "layout" ]]
	then 
		[ $(xkblayout) == "Lit" ] && echo -n " LT " || echo -n " US "
	elif [[ $val == "lock_keys" ]]
	then 
		caps="$(xset -q | awk '/Caps/ {print $4}')"
		num="$(xset -q | awk '/Caps/ {print $8}')"
        [ $caps == "on" ] && echo -n "CAPS | " || echo -n "     | "
        [ $num == "on" ] && echo -n "NUM " || echo -n "    "
	fi
}
module $val
