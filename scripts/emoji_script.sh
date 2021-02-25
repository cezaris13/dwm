#!/bin/bash 
# emoji="$(cat $HOME/.config/dwm/scripts/emoji.txt | dmenu -i -l 20 -fn Monospace-15 | awk '{print $1}' | tr -d '\n' )"
# emoji="$(cat $HOME/.config/dwm/scripts/emoji.txt | rofi  -location 1 -font "Mono 15" -width 100 -dmenu -i  | awk '{print $1}' | tr -d '\n' )"
emoji="$(cat $HOME/.config/dwm/scripts/emoji.txt |  rofi  -modi run -location 1 -width 100 \
		 -lines 20 -line-margin 0 -line-padding 1 \
		 -separator-style none -font "mono 15" -columns 1 -bw 0 \
		 -disable-history \
		 -color-window "#222222, #222222, #b1b4b3" \
		 -color-normal "#222222, #b1b4b3, #222222, #005577, #b1b4b3" \
		 -color-active "#222222, #b1b4b3, #222222, #007763, #b1b4b3" \
		 -color-urgent "#222222, #b1b4b3, #222222, #77003d, #b1b4b3" \
		 -kb-row-select "Tab" -kb-row-tab "" -dmenu -i -p "" \
         -theme-str 'entry { placeholder: ""; } inputbar { children: [prompt, textbox-prompt-colon, entry];}' \
         -theme-str ' inputbar { children: [ prompt, textbox-prompt-colon, entry, case-indicator ];}    textbox-prompt-colon { text-color: inherit; expand: false; margin: 0 0.3em 0em 0em; str: ":"; }' \
         -show | awk '{print $1}' | tr -d '\n' )"

[ ! -z "$emoji" ] && echo -n "$emoji" | xclip -selection clipboard
[ ! -z "$emoji" ] && notify-send "$(xclip -o -selection clipboard) copied to clipboard."
