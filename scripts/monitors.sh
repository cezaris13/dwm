count="$(xrandr --query | grep '\bconnected\b'| wc -l)"
#echo $count
FILE=$HOME/.cache/monitor_orientation.txt
if [ ! -f $FILE ]; then
   touch $FILE
   printf "horizontal\nvertical left\n vertical right" | dmenu -p "choose monitor orientation" > $FILE
fi

if [[ "$(echo $1)" == "change_orientation" ]]
then 
    printf "horizontal\nvertical left\n vertical right" | dmenu -p "choose monitor orientation" > $FILE
fi

if [[ "$count" == "2" ]]
then
#add your arandr layout script here
    if [[ "$(cat $FILE)" == "horizontal" ]]
    then 
        xrandr --output eDP1 --primary --mode 1920x1080 --pos 1920x0 --rotate normal --output DP1 --off --output HDMI1 --off --output HDMI2 --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off
    elif [[ "$(cat $FILE)" == "vertical left" ]]
    then 
        xrandr --output eDP1 --primary --mode 1920x1080 --pos 1080x0 --rotate normal --output DP1 --off --output HDMI1 --off --output HDMI2 --mode 1920x1080 --pos 0x0 --rotate left --output VIRTUAL1 --off
    else
        xrandr --output eDP1 --primary --mode 1920x1080 --pos 1080x0 --rotate normal --output DP1 --off --output HDMI1 --off --output HDMI2 --mode 1920x1080 --pos 0x0 --rotate right --output VIRTUAL1 --off
    fi
elif [[ "$count" == "1" ]] 
then
    xrandr --output eDP1 --primary --mode 1920x1080 --pos 1920x0 --rotate normal --output DP1 --off --output HDMI1 --off --output HDMI2 --off --output VIRTUAL1 --off
fi