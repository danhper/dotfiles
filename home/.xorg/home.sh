#!/bin/bash

external_display=$(xrandr | grep -E ' connected' | grep -v eDP1 | cut -f1 -d' ')
if [ -z "$external_display" ]; then
    sh $HOME/.xorg/laptop.sh
else
    xrandr --output $external_display --mode 1920x1080 --primary  --output eDP1 --mode 3840x2400 --left-of $external_display --scale 0.5x0.5
fi
