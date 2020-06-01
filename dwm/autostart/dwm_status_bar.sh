while true; do
    xsetroot -name "$(/home/pijus/.config/dwm/autostart/./lock_keys.sh;echo -n " | ";/home/pijus/.config/dwm/autostart/./layout.sh;echo -n " | ";/home/pijus/.config/dwm/autostart/./volume.sh;  echo -n " | ";/home/pijus/.config/dwm/autostart/./battery_status.sh; printf " | "; date +"%Y:%m:%d %H:%M:%S")"
    sleep 5s
    # tvarkyti garsa dar
done &
