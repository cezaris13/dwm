command=$($HOME/.config/dwm/scripts/shared/./dmenu_replacement.sh 2 bluetooth_data.txt 10 "Sony_headphones");

earbuds="30:53:C1:3F:9D:F9"

# bluetoothctl pair $earbuds

if [[ "$(echo $command)" == "connect" ]]
then
	bluetoothctl connect $earbuds;
elif [[ "$(echo $command)" == "disconnect" ]]
then
	bluetoothctl disconnect $earbuds;
fi
