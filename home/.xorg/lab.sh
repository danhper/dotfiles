#!/bin/bash

external_display=$(xrandr | grep -E ' connected' | grep -v eDP1 | cut -f1 -d' ')
if [ -z "$external_display"  ]; then
    xrandr --auto
else
    xrandr --output "$external_display" --mode 1920x1200  --primary --output eDP1 --mode 1920x1080  --right-of "$external_display"
fi
