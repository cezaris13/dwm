pkill -RTMIN+10 dwmblocks

mic="$(amixer sget 'Input Source' | awk '{ gsub(" ", "\n") } 1' | awk ' length >0' | grep --color=never -B 1 "Mic" | awk 'NR%2{printf "%s ",$0;next;}1' | grep --color=never "^'" | sed "s/'//g" | dmenu)"
amixer cset name='Input Source',index=0 "$(echo -n "'" ; echo  -n $mic; echo -n "'")"

