#/usr/share/sddm/scripts/ there is xrandr turn on monitors on startup(xsetup)
count="$(xrandr --query | grep '\bconnected\b'| wc -l)"
FILE=$HOME/.cache/MonitorScript/monitor_orientation.txt
WallpaperOne=$HOME/.cache/MonitorScript/Monitor1.txt
WallpaperTwoHoriz=$HOME/.cache/MonitorScript/Monitor2h.txt
WallpaperTwoVert=$HOME/.cache/MonitorScript/Monitor2v.txt

if [ ! -f $FILE ]; then
   touch $FILE
   printf "horizontal\nvertical left\nvertical right" | dmenu -p "choose monitor orientation" > $FILE
fi
if [ ! -f $WallpaperOne ]; then
   touch $WallpaperOne
fi
if [ ! -f $WallpaperTwoHoriz ]; then
   touch $WallpaperTwoHoriz
fi
if [ ! -f $WallpaperTwoVert ]; then
   touch $WallpaperTwoVert
fi

if [[ "$(echo $1)" == "change_orientation" ]]
then 
    printf "horizontal\nvertical left\nvertical right" | dmenu -p "choose monitor orientation" > $FILE
elif [[ "$(echo $1)" == "change_wallpaper" ]]
then
    if [[ "$count" == "2" ]]
    then
        if [[ "$(printf No\\nYes | dmenu -i -sf white -nf gray -p "change wallpaper for monitor 1?")" = Yes ]]
        then
            sxiv -q -t -o $HOME/Pictures/wallpapers/* > $WallpaperOne
        fi
        if [[ "$(cat $FILE)" == "horizontal" ]]
        then
            if [[ "$(printf No\\nYes | dmenu -i -sf white -nf gray -p "change wallpaper for monitor 2 horizontal?")" = Yes ]]
            then
                sxiv -q -t -o $HOME/Pictures/wallpapers/* > $WallpaperTwoHoriz
            fi
        else
            if [[ "$(printf No\\nYes | dmenu -i -sf white -nf gray -p "change wallpaper for monitor 2 vertical?")" = Yes ]]
            then
                sxiv -q -t -o $HOME/Pictures/wallpapers/* > $WallpaperTwovert
            fi
        fi
    elif [[ "$count" == "1" ]]
    then
        sxiv -q -t -o $HOME/Pictures/wallpapers/* > $WallpaperOne
    fi
fi

MonitorOne="$(cat $WallpaperOne)"
MonitorTwoHorizontal="$(cat $WallpaperTwoHoriz)"
MonitorTwoVertical="$(cat $WallpaperTwoVert)"
if [[ "$count" == "2" ]]
then
    if [[ "$(cat $FILE)" == "horizontal" ]]
    then 
#         xrandr --output eDP1 --primary --mode 1920x1080 --pos 1920x0 --rotate normal --output DP1 --off --output HDMI1 --off --output HDMI2 --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off
#         feh --bg-scale $MonitorOne $MonitorTwoHorizontal 
        xrandr --output eDP1 --off --output DP1 --off --output HDMI1 --off --output HDMI2 --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off
        feh --bg-scale $MonitorTwoHorizontal
        # xrandr --output eDP1 --primary --mode 1920x1080 --pos 0x1080 --rotate normal --output DP1 --off --output HDMI1 --off --output HDMI2 --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off
        # feh --bg-scale $MonitorOne $MonitorTwoHorizontal
    elif [[ "$(cat $FILE)" == "vertical left" ]]
    then 
        xrandr --output eDP1 --primary --mode 1920x1080 --pos 1080x0 --rotate normal --output DP1 --off --output HDMI1 --off --output HDMI2 --mode 1920x1080 --pos 0x0 --rotate left --output VIRTUAL1 --off
        feh --bg-scale $MonitorOne $MonitorTwoVertical 
    elif [[ "$(cat $FILE)" == "vertical right" ]]
    then
        xrandr --output eDP1 --primary --mode 1920x1080 --pos 1080x0 --rotate normal --output DP1 --off --output HDMI1 --off --output HDMI2 --mode 1920x1080 --pos 0x0 --rotate right --output VIRTUAL1 --off
        feh --bg-scale $MonitorOne $MonitorTwoVertical
    fi
elif [[ "$count" == "1" ]] 
then
    xrandr --output eDP1 --primary --mode 1920x1080 --pos 1920x0 --rotate normal --output DP1 --off --output HDMI1 --off --output HDMI2 --off --output VIRTUAL1 --off
    feh --bg-scale $MonitorOne
fi
