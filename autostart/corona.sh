cd $HOME/.config/dwm/autostart/;
wget --hsts-file $HOME/.cache/wget-hsts https://en.wikipedia.org/wiki/2020_coronavirus_pandemic_in_Lithuania ;
echo "$(cat 2020_coronavirus_pandemic_in_Lithuania | grep ">Confirmed cases<" | awk '{ gsub("</", "\n") } 1' | grep ">$*[A-Za-z0-9]" | awk '{ gsub(">", "\n") } 1' | grep "^[A-za-z0-9]" | grep -v -e "tr" -e "^th" | sed 's/.*/&:/' | awk 'NR%2{printf "%s ",$0;next;}1' | grep -e "Confirmed" -e "Deaths" | sed 's/.$//')" > 2020_coronavirus_pandemic_in_Lithuania
cat 2020_coronavirus_pandemic_in_Lithuania | dmenu
rm 2020_coronavirus_pandemic_in_Lithuania
