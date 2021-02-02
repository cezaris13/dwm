#!/bin/bash
val=$1
if [[ ! -z $2 ]]
then 
	BLOCK_BUTTON=$2
fi
function module {
	if [[ $val == "battery" ]]
	then 
	   	case $BLOCK_BUTTON in
			1) notify-send "$(echo $(upower -d | grep 'time to empty' | sort -u ))";;
			2) notify-send " mouse battery $(upower -d | grep "percentage" | awk '/ignored/{ print $1 $2}' | grep -m 1 "percentage")";;
			3) notify-send "Battery module
-left click to show time to empty" ;;
		esac
		charging="$(cat /sys/class/power_supply/AC0/online)"
		[ $charging -eq 1 ] && echo -n "    charging " || echo -n " discharging "
		echo -n $(cat /sys/class/power_supply/BAT0/capacity)"% "
	elif [[ $val == "volume" ]]
	then 
		case $BLOCK_BUTTON in
			1) xterm -e alsamixer;;
			2) pactl set-sink-mute 0 toggle;;
			3) notify-send "Volume module" "\- Shows volume, [off] if muted.
-Left click to open alsamixer
- Middle click to mute.
- Scroll to change." ;;
			4) amixer sset Master 5%+ >/dev/null 2>/dev/null ;;
			5) amixer sset Master 5%- >/dev/null 2>/dev/null ;;
		esac
		echo -n "VOL "$(amixer get Master | awk '/Mono.+/ {print $6=="[off]"?$6:$4}')" "
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
