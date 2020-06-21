#!/bin/bash
cd $HOME/.config/dwm/scripts/
wget  "$(echo -e "https://toonily.com/\nhttps://mangakakalot.com/" | dmenu -p "choose the site")"
result="$(echo "$(cat index.html | sed "s/<[^>]*>/-/g;s/ \+/ /g;s/-\+/-/g" | grep -v "[Mm]anga\|^[/({},)/]\|}\?)\?;$\|\-[0-9].\?[0-9]\?\|^ " | grep "-" | grep "\- \?[A-Z]" | grep -vE "[[:upper:]]{3}" | sed "s/[0-9]:/& ccc/" | sed "s/ccc.*$//g" | grep -A1 "\-[A-Z].*[A-Za-z].\?\-"| awk 'length > 2' |sed 's/.$//;s/^.//' |  awk 'NR%2{printf "%s ",$0;next;}1' | grep "Chapter" | sed "s/ \+/ /g;s/ $//g;s/&#8217;/'/g;s/:$//g" | sort -u)" | dmenu -i -l 20 -p "new manga")"
result="$(echo $result | sed "s/[Cc]hapter.*//g" | sed "s/[A-Z]/\L&/g" | sed "s/[Yy]ou're//g;s/[Tt]he//g;s/[']s//g;s/ /-/g;s/[!,;']//g" | grep -o "[A-Za-z].*[A-Za-z]"  ) "
link="$(cat index.html | grep -o " href=\"http.*\"" | grep "[Cc]hapter" | sed "s/\" title.*$//g;s/\/\".\+$//g;s/href=\"//g;s/\/\"$//g" | grep -m1 $result)"
[ ${#result} != 1 ] && [ ${#link} != 0 ] && chromium "$link" # doesn't work with mangakakalot
[ ${#result} != 1 ] && [ ${#link} == 0 ] && notify-send "cannot open manga"
rm index.html
