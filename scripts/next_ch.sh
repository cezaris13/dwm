cd $HOME/.config/dwm/scripts/;
wget -O index.html "$(echo "$( strings ~/'.config/chromium/Default/Current Session' | grep -E --color=never '^https?://' | tac | grep -m1 --color=never "toonily.com/" | sed "s/\/$//g" )" )"
link="$(cat index.html | grep -o " href=\"http.*\"" | grep "[Cc]hapter" | sed "s/\" title.*$//g;s/\/\".\+$//g;s/href=\"//g;s/\/\"$//g" | sort -u | tac | grep -m1 "[Cc]hapter")"
[ "$link" != "" ] && chromium "$link"
rm index.html
