#!/bin/bash

xrandr --output DP-3-2 --primary --mode 1920x1080
xrandr --output eDP-1 --mode 3840x2400 --scale 0.5x0.5 --left-of DP-3-2
xrandr --output DP-3-3 --mode 1920x1080 --right-of DP-3-2
