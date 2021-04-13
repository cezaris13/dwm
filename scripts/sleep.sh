#!/usr/bin/env bash

[ "$(printf No\\nYes | dmenu -i -sf white -nf gray -p "suspend Laptop?")" = Yes ] && systemctl suspend
