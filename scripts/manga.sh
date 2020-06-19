wget  "$(echo -e "https://toonily.com/\nhttps://mangakakalot.com/" | dmenu -p "choose the site")"
echo "$(cat index.html | sed "s/<[^>]*>/-/g;s/ \+/ /g;s/-\+/-/g" | grep -v "^[/({},)/]\|}\?)\?;$\|Manhwa\|[Mm]anga\|\-[0-9].\?[0-9]\?\|^ " | grep "-" | grep "\- \?[A-Z]" | grep -vE "[[:upper:]]{3}" | sed "s/[0-9]:/& ccc/" | sed "s/ccc.*$//g" | grep -A1 "\-[A-Z].*[A-Za-z].\?\-"| awk 'length > 2' |sed 's/.$//;s/^.//' |  awk 'NR%2{printf "%s ",$0;next;}1' | grep "Chapter" | sed "s/ \+/ /g;s/ $//g;s/&#8217;/'/g;s/:$//g" | sort -u)" | dmenu -i -l 20 -p "new manga"
 rm index.html
