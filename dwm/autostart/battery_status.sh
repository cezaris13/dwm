#!/bin/bash
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
