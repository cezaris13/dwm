cd $HOME/.config/dwm/scripts;
wget https://rezultatai.nec.lt/
if [[ ! -f "index.html" ]]
then 
	echo "nera puslapiuko" | dmenu -p "neco rezultatai"
else
	chromium  https://rezultatai.nec.lt/
fi
