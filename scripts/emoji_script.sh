#!/bin/bash 
emoji="$(cat $HOME/.config/dwm/scripts/emoji.txt | dmenu -i -l 20 -fn Monospace-15 | awk '{print $1}' | tr -d '\n' )"
[ ! -z "$emoji" ] && echo -n "$emoji" | xclip -selection clipboard
[ ! -z "$emoji" ] && notify-send "$(xclip -o -selection clipboard) copied to clipboard."
