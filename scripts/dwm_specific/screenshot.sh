#!/bin/sh

function launch_spectacle() {
	if pgrep -x spectacle >/dev/null; then
		killall spectacle
		spectacle -r
	else
		spectacle
	fi
}

function launch_rectangular_region_in_background() {
	spectacle -r -bc
}

case "$1" in
	"") ;;
	launch_spectacle) "$@"; exit;;
	launch_rectangular_region_in_background) "$@"; exit;;
	*) echo "unknown command"; exit 2;;
esac
