case $BLOCK_BUTTON in
	1) notify-send "This Month" "$(cal --color=always -m | sed "s/..7m/<b><span color=\"red\">/;s/..27m/<\/span><\/b>/")" ;;
	3) notify-send "Time/date module" "\- Left click to show the month via \`cal\`" ;;
esac
echo "$(date +"%Y:%m:%d %H:%M:%S") "
