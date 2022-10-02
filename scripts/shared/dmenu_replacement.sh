cd $HOME/.config/dwm/scripts/shared
line_number=$1
template_data=$2
font_size=$3
dmenu_text=$4
cat $(echo "../templates/"$template_data) | rofi -modi run -location 1 -width 100 \
	-lines $line_number -line-margin 0 -line-padding 1 \
	-disable-history \
	-hide-scrollbar \
	-color-window "#222222, #222222, #b1b4b3" \
	-color-normal "#222222, #b1b4b3, #222222, #005577, #b1b4b3" \
	-color-active "#222222, #b1b4b3, #222222, #007763, #b1b4b3" \
	-color-urgent "#222222, #b1b4b3, #222222, #77003d, #b1b4b3" \
	-kb-row-select "Tab" -kb-row-tab "" -dmenu -i -p $(echo $dmenu_text) \
	-separator-style none -font "$(echo "mono" $font_size)" -columns 1 -bw 0 \
	-theme-str 'entry { placeholder: ""; } inputbar { children: [prompt, textbox-prompt-colon, entry];}' \
	-theme-str ' inputbar { children: [ prompt, textbox-prompt-colon, entry, case-indicator ];}    textbox-prompt-colon { text-color: inherit; expand: false; margin: 0 0.3em 0em 0em; str: ":"; }' \
	-show | awk '{print $1}' | tr -d '\n'
