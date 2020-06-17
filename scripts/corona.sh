cd $HOME/.config/dwm/scripts/;
wget --hsts-file $HOME/.cache/wget-hsts https://en.wikipedia.org/wiki/2020_coronavirus_pandemic_in_Lithuania ;
echo "$(cat 2020_coronavirus_pandemic_in_Lithuania | grep ">Confirmed cases<" | sed "s/<[^>]*>/: /g" | awk '{ gsub(":", ":\n") } 1' | awk 'length > 2' | grep -v "^.[,()&]" | awk 'NR%2{printf "%s ",$0;next;}1' | grep -e "Confirmed cases:" -e "Deaths" | sed 's/.$//;s/^ //')" > 2020_coronavirus_pandemic_in_Lithuania
cat 2020_coronavirus_pandemic_in_Lithuania | dmenu
rm 2020_coronavirus_pandemic_in_Lithuania
