#!/usr/bin/env bash

Id=$(xinput list --id-only 'MX Master 3 B Mouse')
xinput set-button-map $Id 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
