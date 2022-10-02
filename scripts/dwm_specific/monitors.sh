#!/bin/sh
#/usr/share/sddm/scripts/ there is xrandr turn on monitors on startup(xsetup)
count="$(xrandr --query | grep '\bconnected\b' | wc -l)"
FILE=$HOME/.cache/MonitorScript/monitor_orientation.txt
wallpaper_one=$HOME/.cache/MonitorScript/monitor1.txt
wallpaper_two_horiz=$HOME/.cache/MonitorScript/monitor2h.txt
wallpaper_two_vert=$HOME/.cache/MonitorScript/monitor2v.txt
wallpaper_directory=$HOME/Pictures/wallpapers/*

if [ ! -f $FILE ]; then
    touch $FILE
    printf "horizontal\nvertical left\nvertical right" | dmenu -p "choose monitor orientation" >$FILE
fi

function create_wallpaper_files_if_not_exist() {
    if [ ! -f $wallpaper_one ]; then
        touch $wallpaper_one
    fi

    if [ ! -f $wallpaper_two_horiz ]; then
        touch $wallpaper_two_horiz
    fi

    if [ ! -f $wallpaper_two_vert ]; then
        touch $wallpaper_two_vert
    fi
}

function change_monitor_orientation_or_wallpaper() {
    if [[ "$1" == "change_orientation" ]]; then
        printf "horizontal\nvertical left\nvertical right" | dmenu -p "choose monitor orientation" >$FILE
    elif [[ "$1" == "change_wallpaper" ]]; then
        if [[ "$count" == "2" || "$count" == "3" ]]; then
            if [[ "$(printf No\\nYes | dmenu -i -sf white -nf gray -p "change wallpaper for monitor 1?")" = Yes ]]; then
                sxiv -q -t -o $wallpaper_directory >$wallpaper_one
            fi
            if [[ "$(cat $FILE)" == "horizontal" ]]; then
                if [[ "$(printf No\\nYes | dmenu -i -sf white -nf gray -p "change wallpaper for monitor 2 horizontal?")" = Yes ]]; then
                    sxiv -q -t -o $wallpaper_directory >$wallpaper_two_horiz
                fi
            else
                if [[ "$(printf No\\nYes | dmenu -i -sf white -nf gray -p "change wallpaper for monitor 2 vertical?")" = Yes ]]; then
                    sxiv -q -t -o $wallpaper_directory >$wallpaper_two_vert
                fi
            fi
        elif [[ "$count" == "1" ]]; then
            sxiv -q -t -o $wallpaper_directory >$wallpaper_one
        fi
    fi
}

function set_monitor_orientation() {
    monitor_one="$(cat $wallpaper_one)"
    monitor_two_horizontal="$(cat $wallpaper_two_horiz)"
    monitor_two_vertical="$(cat $wallpaper_two_vert)"
    if [[ "$count" == "3" ]]; then
        xrandr --output eDP1 --off --output DP1 --mode 1920x1200 --pos 1920x0 --rotate normal --output HDMI1 --off --output HDMI2 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off
        feh --bg-scale $monitor_one $monitor_two_horizontal
    elif [[ "$count" == "2" ]]; then
        if [[ "$(cat $FILE)" == "horizontal" ]]; then
            # xrandr --output eDP1 --primary --mode 1920x1080 --pos 1920x0 --rotate normal --output DP1 --off --output HDMI1 --off --output HDMI2 --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off
            # feh --bg-scale $monitor_one $monitor_two_horizontal
            xrandr --output eDP1 --off --output DP1 --off --output HDMI1 --off --output HDMI2 --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off
            feh --bg-scale $monitor_two_horizontal
            # xrandr --output eDP1 --primary --mode 1920x1080 --pos 0x1080 --rotate normal --output DP1 --off --output HDMI1 --off --output HDMI2 --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off
            # feh --bg-scale $monitor_one $monitor_two_horizontal
        elif [[ "$(cat $FILE)" == "vertical left" ]]; then
            xrandr --output eDP1 --primary --mode 1920x1080 --pos 1080x0 --rotate normal --output DP1 --off --output HDMI1 --off --output HDMI2 --mode 1920x1080 --pos 0x0 --rotate left --output VIRTUAL1 --off
            feh --bg-scale $monitor_one $monitor_two_vertical
        elif [[ "$(cat $FILE)" == "vertical right" ]]; then
            xrandr --output eDP1 --primary --mode 1920x1080 --pos 1080x0 --rotate normal --output DP1 --off --output HDMI1 --off --output HDMI2 --mode 1920x1080 --pos 0x0 --rotate right --output VIRTUAL1 --off
            feh --bg-scale $monitor_one $monitor_two_vertical
        fi
    elif [[ "$count" == "1" ]]; then
        xrandr --output eDP1 --primary --mode 1920x1080 --pos 1920x0 --rotate normal --output DP1 --off --output HDMI1 --off --output HDMI2 --off --output VIRTUAL1 --off
        feh --bg-scale $monitor_one
    fi
}

create_wallpaper_files_if_not_exist
change_monitor_orientation_or_wallpaper $1
set_monitor_orientation
