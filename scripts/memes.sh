cd $HOME/Pictures/memes/
image="$(ls *.png *.jpg *.jpeg | dmenu -l 20 -p "choose your meme" )"
xclip -selection clipboard -target image/png $image
echo $image
notify-send -i $HOME/Pictures/memes/$image "$( echo $image | grep --color=never -o "[A-Za-z].*\." | sed "s/\.$//g;s/_/ /g")
copied to clipboard"


