#!/bin/bash
 case $BLOCK_BUTTON in
	3) notify-send "🔋 Battery module" "🔋: discharging
🛑: not charging
♻: stagnant charge
🔌: charging
⚡: charged
❗: battery very low!" ;;
	6) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac
 charging="$(cat /sys/class/power_supply/AC0/online)"
if [[ $charging -eq 1 ]]
then
	echo -n "   charging "
else
	echo -n "discharging "
fi
percentage="$(cat /sys/class/power_supply/BAT0/capacity)"
echo -n $percentage"% "

