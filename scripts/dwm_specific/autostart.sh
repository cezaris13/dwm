wal -i "$(<"${HOME}/.cache/wal/wal")" &
$HOME/.config/dwm/scripts/dwm_specific/./monitors.sh &
dwmblocks &
nm-applet &
klipper &
/usr/lib/polkit-kde-authentication-agent-1 &
setxkbmap -layout us,lt -option 'grp:alt_shift_toggle' & #sita reiks pakoreguoti kad butu su dwm pkill
$HOME/.config/dwm/scripts/dwm_specific/./keyboard.sh &
xbindkeys &
numlockx on &
dunst &
fusuma &
xinput --set-prop "Elan Touchpad" "libinput Natural Scrolling Enabled" 1 # reverse scrolling
xinput --set-prop "Elan Touchpad" "libinput Tapping Enabled" 1           #tap clicking
redshift &
sleep 1;picom -b &
# mailspring &
kdeconnect-cli --refresh &
xmodmap $HOME/.Xmodmap
# # pulseaudio-equalizer enable &
