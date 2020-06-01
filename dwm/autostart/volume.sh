#volume="$(awk -F"[][]" '/dB/ { print $2 }' <(amixer sget Master))" 
volume="$(amixer get Master | awk '/Mono.+/ {print $6=="[off]"?$6:$4}')"
echo -n "VOL "$volume
