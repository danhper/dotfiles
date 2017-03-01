#!/bin/bash

xrandr | grep -q "VGA1 connected"
vga_connected=$?


if [ $vga_connected -eq 0 ]; then
    xrandr --output eDP1 --mode 1920x1080 --primary --output HDMI1 --mode 1920x1080 --right-of eDP1 --output VGA1 --mode 1920x1080 --left-of eDP1
else
    xrandr --output eDP1 --mode 1920x1080 --primary --output HDMI1 --mode 1920x1080 --right-of eDP1
fi
