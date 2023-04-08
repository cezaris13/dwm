wal -n -i "$(<"${HOME}/.cache/wal/wal")" &
$HOME/.config/dwm/scripts/dwm_specific/./monitors.sh &
dwmblocks &
nm-applet &
klipper &
/usr/lib/polkit-kde-authentication-agent-1 &
setxkbmap -layout us,lt -option 'grp:alt_shift_toggle' & #sita reiks pakoreguoti kad butu su dwm pkill
$HOME/.config/dwm/scripts/dwm_specific/./keyboard.sh &
xbindkeys -f $HOME/.config/dwm/configs/xbindkeysrc  &
numlockx on &
dunst -config $HOME/.config/dwm/configs/dunstrc &
fusuma --config $HOME/.config/dwm/configs/fusuma.yml &
xinput --set-prop "Elan Touchpad" "libinput Natural Scrolling Enabled" 1 # reverse scrolling
xinput --set-prop "Elan Touchpad" "libinput Tapping Enabled" 1           #tap clicking
redshift &
sleep 1; picom -b --config $HOME/.config/dwm/configs/picom.conf &
kdeconnect-cli --refresh &
xmodmap $HOME/.Xmodmap
# # pulseaudio-equalizer enable &
skippy-xd --config $HOME/.config/dwm/configs/skippy-xd.rc --start-daemon &
xdotool behave_screen_edge top-right exec sh $HOME/.config/dwm/scripts/dwm_specific/./open_all_windows.sh 1 &
tvolnoti --config $HOME/.config/dwm/configs/tvolnoti/tvolnoti.conf &
$HOME/.config/dwm/scripts/dwm_specific/./network.sh &
