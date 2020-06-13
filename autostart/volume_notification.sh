kill -44 $(pidof dwmblocks) && notify-send --hint=string:x-dunst-stack-tag:test "volume $(amixer get Master | awk '/Mono.+/ {print $6=="[off]"?$6:$4}')"
