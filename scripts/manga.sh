#!/bin/bash
cd $HOME/.config/dwm/scripts/
curl "$(echo -e "https://toonily.com/webtoons/?m_orderby=latest\nhttps://mangakakalot.com/" | dmenu -p "choose the site")" > index.html #toonily does not work for now, maybe reboot will do the thing
result="$(cat index.html | sed "s/>/>\n/g" | sed "s/<[^>]*>/-/g;s/ \+/ /g;s/-\+/-/g" | awk 'length > 4' | grep -B1 "Chapter "  | grep -vA1 "Chapter " | awk 'length > 4' | sed "s/\-//g" | awk 'NR%2{printf "%s ",$0;next;}1' | grep -v "^[0-9]" | dmenu -i -l 20 -p "new manga")"
result="$(echo $result | sed "s/[Cc]hapter.*//g" | sed "s/[A-Z]/\L&/g" | sed "s/[Yy]ou're//g;s/[Tt]he//g;s/[']s//g;s/ /-/g;s/[!,;']//g" | grep -o "[A-Za-z].*[A-Za-z]"  ) " #optimise later
link="$(cat index.html | grep -o " href=\"http.*\"" | grep "[Cc]hapter" | sed "s/\" title.*$//g;s/\/\".\+$//g;s/href=\"//g;s/\/\"$//g" | grep -m1 $result)"#same goes here
[ ${#result} != 1 ] && [ ${#link} != 0 ] && chromium "$link" # doesn't work with mangakakalot
[ ${#result} != 1 ] && [ ${#link} == 0 ] && notify-send "cannot open manga"# remember what ${#link} does
rm index.html
