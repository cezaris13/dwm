# wget https://toonily.com/
# echo "$(cat index.html | sed "s/<[^>]*>/-/g;s/ \+/ /g;s/-\+/-/g" | awk 'length > 2' | grep -v "^[&/(]" | grep -v "})\?;$" | grep -v ");$" | grep -v "[{},);/]" | grep "-" | awk '/-18\+-NEW-/{getline; print; getline;getline; print;ge}' | awk '/Chapter/{ print; getline; print}' |sed 's/.$//;s/^.//' | awk 'length > 2' | awk 'NR%2{printf "%s ",$0;next;}1' | grep -v "Chapter.*Chapter" | grep -v "^ " )" | dmenu -p "new manga"
# rm index.html

wget https://toonily.com/
echo "$(cat index.html | sed "s/<[^>]*>/-/g;s/ \+/ /g;s/-\+/-/g" | grep -v "^[/({},)/]\|}\?)\?;$\|Manhwa\|\-[0-9].\?[0-9]\?" | grep "-" | grep "\- \?[A-Z]" | grep -vE "[[:upper:]]{3}" | grep -A1 "\-[A-Z].*[A-Za-z].\?\-"| awk 'length > 2' |sed 's/.$//;s/^.//' |  awk 'NR%2{printf "%s ",$0;next;}1' | grep "Chapter" | sed "s/ \+/ /g;s/ $//g;s/&#8217;/'/g" | sort -u)" | dmenu -i -l 20 -p "new manga"
rm index.html
