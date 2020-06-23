cd $HOME/Pictures/memes/
image="$(ls *.png | sed "s/_/ /g;s/\.png//g" | dmenu -l 20 -p "choose your meme" )"
image="$(echo -n $image | sed "s/ /_/g"; echo -n ".png")"
[ "$image" != ".png" ] && xclip -selection clipboard -target image/png $image
[ "$image" != ".png" ] && notify-send -i $HOME/Pictures/memes/$image "$( echo $image | grep --color=never -o "[A-Za-z].*\." | sed "s/\.$//g;s/_/ /g")
copied to clipboard"
