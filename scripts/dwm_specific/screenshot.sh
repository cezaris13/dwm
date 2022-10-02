#!/bin/sh

function launch_spectacle() {
	if pgrep -x spectacle >/dev/null; then
		killall spectacle
		spectacle -r
	else
		spectacle
	fi
}

launch_spectacle
