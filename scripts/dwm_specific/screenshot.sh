if pgrep -x spectacle >/dev/null
then
	killall spectacle; spectacle -r;
else
	spectacle;
fi
