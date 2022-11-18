layout=$(xkb-switch -p);
xkb-switch -s us;
rofi -show drun;
xkb-switch -s ${layout}

