#!/bin/bash

function toggle_windows() {
	close=$1
	if [[ $close -eq "1" ]]; then
			isSkippyActive=$(pgrep -f "skippy-xd --config.*$")
			echo $isSkippyActive;
			if [[ $isSkippyActive ]]; then
			   pkill -TERM -f "skippy-xd --config.*$"
			else
				skippy-xd --config $HOME/.config/dwm/configs/skippy-xd.rc;
			fi
	else
			skippy-xd --start-daemon &
			skippy-xd --config $HOME/.config/dwm/configs/skippy-xd.rc;
	fi
}

toggle_windows $1
