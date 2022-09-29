kill -44 $(pidof dwmblocks) && notify-send --hint=string:x-dunst-stack-tag:volume "volume $(sh $HOME/.config/dwm/scripts/dwm_specific/volume/./volume_percentage.sh)"
