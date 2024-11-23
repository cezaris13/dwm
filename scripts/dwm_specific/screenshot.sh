#!/bin/sh

function launch_spectacle() {
	if pgrep -x spectacle >/dev/null; then
		killall flameshot
		flameshot gui -c
	else
		flameshot gui -c
	fi
}

function launch_rectangular_region_in_background() {
	flameshot gui -c
}

case "$1" in
	"") ;;
	launch_spectacle) "$@"; exit;;
	launch_rectangular_region_in_background) "$@"; exit;;
	*) echo "unknown command"; exit 2;;
esac
