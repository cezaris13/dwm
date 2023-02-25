#!/bin/bash

function toggle_windows() {
	close=$1
	is_skippyXd_running=$(ps -aux | grep "skippy-xd" | grep -v "grep")
	notify-send $is_skippyXd_running
	if [[ ! -z "$is_skippyXd_running" ]]; then
		if [[ $close -eq "1" ]]; then
			killall skippy-xd;
		fi
	else
		skippy-xd;
	fi
}

toggle_windows $1
