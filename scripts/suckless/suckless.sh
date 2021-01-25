#!/bin/bash
wget https://dwm.suckless.org/patches/activetagindicatorbar/
cat index.html | grep "patches" | sed "s/\s*<li><a href=\"\/\///g" |  sed "s/\".*//g" > links.txt
rm index.html
wget -i links.txt
for file in /home/pijus/.config/dwm/scripts/suckless/*
do
    if [[ "$(echo "$file" | grep -o "html")" == "html" ]] 
    then 
        echo "$(cat "$file" | grep -B2 "<p>" | grep -v "img src" | grep -v "<\/\?li>" | grep -v "<\/\?ol>" |grep -v "<\/\?ul>" |  grep -v "<\/\?em>" | grep -v "<\/\?pre>" | awk 'length >2' | sed "s/<\/\?p>//g;s/<\/\?h[1-2]>//g;s/<\/\?.*>//g")" >> desc.txt
        echo "" >> desc.txt
        rm $file
    fi
done
