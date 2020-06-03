case $BLOCK_BUTTON in
	1) notify-send "This Month" "$(cal --color=always -m | sed "s/..7m/<b><span color=\"red\">/;s/..27m/<\/span><\/b>/")" ;;
	2) setsid -f "$TERMINAL" -e calcurse -D ~/.config/calcurse ;;
	3) notify-send "📅 Time/date module" "\- Left click to show upcoming appointments for the next three days via \`calcurse -d3\` and show the month via \`cal\`
- Middle click opens calcurse if installed" ;;
	6) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac
echo "$(date +"%Y:%m:%d %H:%M:%S") "
