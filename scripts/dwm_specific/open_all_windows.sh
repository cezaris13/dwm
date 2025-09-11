#!/bin/bash

function toggle_windows() {
	close=$1
	if [[ $close -eq "1" ]]; then
			isSkippyActive=$(pgrep -f "skippy-xd$")
			echo $isSkippyActive;
			if [[ $isSkippyActive ]]; then
			   pkill -TERM -f "skippy-xd$"
			else
				skippy-xd;
			fi
	else
			skippy-xd --start-daemon &
			skippy-xd;
	fi
}

toggle_windows $1
