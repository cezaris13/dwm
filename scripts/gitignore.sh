#!/bin/bash
dir="$(pwd)"
cd $HOME/Desktop/Projects/gitignore
ans="$(ls *.gitignore | sed "s/.gitignore//g" | dmenu -i -l 20 -p "choose your language for gitignore" )"
ans="$(echo -n $ans | sed "s/$/.gitignore/g")"
cp $ans $dir 
cd $dir
mv $ans .gitignore
