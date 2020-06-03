 num="$(xset -q | grep Caps | awk '{print $8}')"
if [[ $num == "on" ]]
then 
	echo -n "NUM"
else 
	echo -n "   "
fi
