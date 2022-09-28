pacmd list-sinks | grep "bluez\.alias.*$" | sed "s/\s//g; s/bluez\.alias=\"//g;s/\"//g"
