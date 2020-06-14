python luke.py
cat result | sed "s/<[^>]*>/;/g" | sed "s/ \+/ /g" |  awk '{ gsub(";", "\n") } 1' | awk 'length > 2' | tac | awk '/ago/{print $0; getline;getline;getline; print}' | tac | awk 'NR%2{printf "%s ",$0;next;}1' | grep -v "YouTube" | grep -m 1 "ago" | dmenu
rm result
