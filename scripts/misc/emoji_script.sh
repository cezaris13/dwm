#!/bin/bash 
# emoji="$(cat $HOME/.config/dwm/scripts/emoji.txt | dmenu -i -l 20 -fn Monospace-15 | awk '{print $1}' | tr -d '\n' )"
# emoji="$(cat $HOME/.config/dwm/scripts/emoji.txt | rofi  -location 1 -font "Mono 15" -width 100 -dmenu -i  | awk '{print $1}' | tr -d '\n' )"
emoji="$($HOME/.config/dwm/scripts/shared/./dmenu_replacement.sh 20 emoji_data.txt 15)"

[ ! -z "$emoji" ] && echo -n "$emoji" | xclip -selection clipboard
[ ! -z "$emoji" ] && notify-send "$(xclip -o -selection clipboard) copied to clipboard."
