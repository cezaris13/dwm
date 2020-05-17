 caps="$(xset -q | grep Caps | awk '{print $4}')"
 num="$(xset -q | grep Caps | awk '{print $8}')"
if [[ $caps == "on" ]]
then 
	echo -n "CAPS | "
else
	echo -n "     | "
fi
if [[ $num == "on" ]]
then 
	echo -n "NUM"
else 
	echo -n "   "
fi
