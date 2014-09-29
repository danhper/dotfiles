#!/bin/bash

xrandr | grep VGA | grep " connected " > /dev/null
vga_connected=$?
xrandr | grep HDMI | grep " connected " > /dev/null
hdmi_connected=$?
if [ $hdmi_connected -eq 0 ] && [ $vga_connected -eq 0 ]; then
  xrandr --output HDMI1 --primary --mode 1920x1080 --output VGA1 --left-of HDMI1 --output eDP1 --right-of HDMI1
  xset m 4/3 8
else
  xrandr --auto
fi

