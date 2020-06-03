lang="$(xkblayout)"
#echo -n  "⌨"
if [[ $lang == "Lit" ]]
then 
	echo -n " LT "
elif [[ $lang == "Eng" ]]
then 
	echo -n " US "
fi
