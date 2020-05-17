#!/bin/bash
 charging="$(cat /sys/class/power_supply/AC0/online)"
if [[ $charging -eq 1 ]]
then
	echo -n "   charging "
else
	echo -n "discharging "
fi
percentage="$(cat /sys/class/power_supply/BAT0/capacity)"
echo -n $percentage"%"

#setxkbmap -query | awk '/layout/{ print $2 }'
