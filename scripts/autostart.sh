klipper &
/usr/lib/polkit-kde-authentication-agent-1 &
wal -i "$(< "${HOME}/.cache/wal/wal")" &
setxkbmap -layout us,lt -option 'grp:alt_shift_toggle' & #sita reiks pakoreguoti kad butu su dwm pkill
xbindkeys &
nitrogen --restore; sleep 1; picom -b &
numlockx on &
dunst &
# compton &
fusuma &
xinput --set-prop "Elan Touchpad" "libinput Natural Scrolling Enabled" 1 # reverse scrolling
xinput --set-prop "Elan Touchpad" "libinput Tapping Enabled" 1 #tap clicking
redshift &
dwmblocks &