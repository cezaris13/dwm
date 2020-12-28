if [ "$(printf No\\nYes | dmenu -i -sf white -nf gray -p "Check if there's a new video of Luke Smith?")" = Yes ] 
then
    cd $HOME/.config/dwm/scripts/;
    notify-send "information is beeing processed..."; python luke.py
    cat result | sed "s/<[^>]*>/;/g;s/ \+/ /g" |  awk '{ gsub(";", "\n") } 1' | awk 'length > 2' | grep -B2 "ago" | grep -v "\-\-\|@Luke" | awk 'NR%2{printf "%s ",$0;next;}1' | head -n 1 | dmenu 
    rm result
fi
