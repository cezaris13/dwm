notify-send --hint=string:x-dunst-stack-tag:brightness "brightness: $(printf "%.0f\n" $(xbacklight -get)) %"
