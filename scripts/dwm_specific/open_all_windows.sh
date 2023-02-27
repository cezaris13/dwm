#!/bin/bash

function toggle_windows() {
	close=$1
	if [[ $close -eq "1" ]]; then
			skippy-xd --toggle-window-picker;
	else
			skippy-xd --activate-window-picker;
	fi
}

toggle_windows $1
