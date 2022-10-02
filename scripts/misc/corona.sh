cd $HOME/.config/dwm/scripts/misc/
wget --hsts-file $HOME/.cache/wget-hsts https://en.wikipedia.org/wiki/2020_coronavirus_pandemic_in_Lithuania
cat 2020_coronavirus_pandemic_in_Lithuania | grep ">Confirmed cases<" | sed "s/<[^>]*>/: /g" | awk '{ gsub(":", ":\n") } 1' | awk 'length > 2' | grep -A1 "Confirmed\|Deaths" | grep -v "-" | awk 'NR%2{printf "%s ",$0;next;}1' | sed "s/:$//g" | dmenu
rm 2020_coronavirus_pandemic_in_Lithuania
