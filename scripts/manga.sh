#!/bin/bash
cd $HOME/.config/dwm/scripts/
curl "$(echo -e "https://toonily.com/webtoons/?m_orderby=latest\nhttps://mangakakalot.com/" | dmenu -p "choose the site")" > index.html #toonily does not work for now, maybe reboot will do the thing
cat index.html | sed "s/>/>\n/g" | grep "</a>\|<a href.*>" | grep -v  "^ *</a>$" | grep -A1 "href" | grep -vB1 "href" | grep -v "\-\-" | awk 'NR%2{printf "%s ",$0;next;}1'  | sed "s/<a \+href=.//g;s/<\/a>//g" | grep " *https\?://" > links_and_titles.txt
result="$(cat links_and_titles.txt | grep -o ">.*$" | grep -B1 "Chapter" | sed "s/> *//g" | grep -vA1 "Chapter" |awk 'length >2'|  awk 'NR%2{printf "%s ",$0;next;}1' |  dmenu -i -l 20 -p "new manga")"
result=$(echo $result | sed "s/Chapter.*$//g" | sed "s/^ \+//g" | sed "s/ \+$//g")
link=$(cat links_and_titles.txt | grep -A1 "$result" | grep "Chapter" | sed 's/".*$//g;s/^ \+//g'| grep -m1 "https\?") 
# todo vol for mangakakalot
#3 seds into 1 line 6
[ ${#result} != 0 ] && [ ${#link} != 0 ] && chromium "$link"
rm index.html
rm links_and_titles.txt