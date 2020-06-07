case $BLOCK_BUTTON in
	1)pkill -RTMIN+4 dwmblocks;;
	2)xterm -e nmtui;;
    3) notify-send "Internet module" "\- Click to connect
down: no wifi connection
ip adress: wifi connection with quality
-middle click: open nmtui";;
esac
ip="$(ip addr show | awk '{print$2}' | grep -i "192")"
case "$(cat /sys/class/net/w*/operstate 2>/dev/null)" in
	down) echo -n 'down ';;
	up) echo "${ip%%/*} "
esac
