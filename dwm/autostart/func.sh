val=$1

function module {
	if [[ $val == "bat" ]]
	then 
	   	case $BLOCK_BUTTON in
			1) notify-send "$(echo $(upower -d | grep 'time to empty' | sort -u ))";;
			2)notify-send " mouse battery $(upower -d | grep "percentage" |grep "ignored" | awk '{ print $1 $2}')";;
			3) notify-send "Battery module
-left click to show time to empty" ;;
		esac
		charging="$(cat /sys/class/power_supply/AC0/online)"
		if [[ $charging -eq 1 ]]
		then
			echo -n "    charging "
		else
			echo -n " discharging "
		fi
		percentage="$(cat /sys/class/power_supply/BAT0/capacity)"
		echo -n $percentage"% "
	elif [[ $val == "vol" ]]
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
			6) "$TERMINAL" -e "$EDITOR" "$0" ;;
		esac
		volume="$(amixer get Master | awk '/Mono.+/ {print $6=="[off]"?$6:$4}')"
		echo -n "VOL "$volume" "
	elif [[ $val == "net" ]]
	then 
		case $BLOCK_BUTTON in
			1)pkill -RTMIN+4 dwmblocks;;
			2)xterm -e nmtui;;
			3) notify-send "Internet module" "\- Click to connect
down: no wifi connection
ip adress: wifi connection with quality
-middle click: open nmtui";;
		esac
		ip="$(ip addr show | awk '{print$2}' | grep -i "192")"
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
		lang="$(xkblayout)"
		if [[ $lang == "Lit" ]]
		then
			echo -n " LT "
		elif [[ $lang == "Eng" ]]
		then
			echo -n " US "
		fi
	elif [[ $val == "lock_keys" ]]
	then 
		caps="$(xset -q | grep Caps | awk '{print $4}')"
		num="$(xset -q | grep Caps | awk '{print $8}')"
		if [[ $caps == "on" ]]
		then
			echo -n "CAPS | "
		else
			echo -n "     | "
		fi
		if [[ $num == "on" ]]
		then
			echo -n "NUM "
		else
			echo -n "    "
		fi
	fi
}
 
module $val
