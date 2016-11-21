#!/bin/bash

xrandr | grep -q "VGA1 connected"
vga_connected=$?

if [ $vga_connected -eq 0 ]; then
    xrandr --output HDMI1 --mode 2560x1440 --primary --output eDP1 --mode 1920x1080 --left-of HDMI1 --output VGA1 --mode 1200x1600 --right-of HDMI1
else
    xrandr --output HDMI1 --mode 2560x1440 --primary --output eDP1 --mode 1920x1080 --left-of HDMI1
fi
