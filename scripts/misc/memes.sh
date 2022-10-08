cd $HOME/Pictures/memes/
image="$(ls *.png | sed "s/_/ /g;s/\.png//g" | rofi -modi run -location 1 -width 100 \
	-lines 20 -line-margin 0 -line-padding 1 \
	-separator-style none -font "mono 10" -columns 1 -bw 0 \
	-disable-history \
	-hide-scrollbar \
	-color-window "#222222, #222222, #b1b4b3" \
	-color-normal "#222222, #b1b4b3, #222222, #005577, #b1b4b3" \
	-color-active "#222222, #b1b4b3, #222222, #007763, #b1b4b3" \
	-color-urgent "#222222, #b1b4b3, #222222, #77003d, #b1b4b3" \
	-kb-row-select "Tab" -kb-row-tab "" -dmenu -i -p "choose your meme" \
	-theme-str 'entry { placeholder: ""; } inputbar { children: [prompt, textbox-prompt-colon, entry];}' \
	-theme-str ' inputbar { children: [ prompt, textbox-prompt-colon, entry, case-indicator ];}    textbox-prompt-colon { text-color: inherit; expand: false; margin: 0 0.3em 0em 0em; str: ":"; }' \
	-show)"
image="$(echo -n $image | sed "s/ /_/g; s/$/.png/g")"
[ "$image" != ".png" ] && xclip -selection clipboard -target image/png $image
[ "$image" != ".png" ] && notify-send -i $HOME/Pictures/memes/$image "$(echo $image | grep --color=never -o "[A-Za-z].*\." | sed "s/\.$//g;s/_/ /g")
copied to clipboard"
