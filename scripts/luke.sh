if [ "$(printf No\\nYes | dmenu -i -sf white -nf gray -p "Check if there's a new video of Luke Smith?")" = Yes ] 
then
    cd $HOME/.config/dwm/scripts/;
    notify-send "information is beeing processed..."; python luke.py
    cat result | sed "s/<[^>]*>/;/g;s/ \+/ /g" |  awk '{ gsub(";", "\n") } 1' | awk 'length > 2' | tac | awk '/ago/{print $0; getline;getline;getline; print}' | tac | awk 'NR%2{printf "%s ",$0;next;}1' | grep -v "YouTube" | grep -v "[Ss]ecure login"| grep -m 1 "ago" | dmenu
    rm result
fi
