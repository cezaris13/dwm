case $BLOCK_BUTTON in
	1) xterm -e alsamixer;;
	2) pactl set-sink-mute 0 toggle;;
	3) notify-send "Volume module" "\- Shows volume, [off] if muted.
-Left click to open alsamixer
- Middle click to mute.
- Scroll to change." ;;
	4) amixer sset Master 5%+ >/dev/null 2>/dev/null ;;
	5) amixer sset Master 5%- >/dev/null 2>/dev/null ;;
	6) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac
volume="$(amixer get Master | awk '/Mono.+/ {print $6=="[off]"?$6:$4}')"
echo -n "VOL "$volume" "
