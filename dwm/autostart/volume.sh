case $BLOCK_BUTTON in
	1) st -e alsamixer ;;
	2) amixer sset Master toggle ;;
	3) notify-send "📢 Volume module" "\- Shows volume 🔊, 🔇 if muted.
- Middle click to mute.
- Scroll to change." ;;
	4) amixer sset Master 5%+ >/dev/null 2>/dev/null ;;
	5) amixer sset Master 5%- >/dev/null 2>/dev/null ;;
	6) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac
volume="$(amixer get Master | awk '/Mono.+/ {print $6=="[off]"?$6:$4}')"
echo -n "VOL "$volume" "
