#!/bin/bash 
cat $HOME/.config/dwm/scripts/emoji.txt | dmenu -i -l 20 -fn Monospace-15 | awk '{print $1}' | tr -d '\n' | xclip -selection clipboard
[ ! -z "$(xclip -o -selection clipboard)" ] &&  notify-send "$(xclip -o -selection clipboard) copied to clipboard."
