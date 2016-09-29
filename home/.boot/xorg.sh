#!/bin/bash

if [ "$CURRENT_ENV" = "lab" ]; then
    [ -f ~/.xorg/lab.sh ] && . ~/.xorg/lab.sh
elif [ "$CURRENT_ENV" = "office" ]; then
    [ -f ~/.xorg/office.sh ] && . ~/.xorg/office.sh
else
    xrandr --auto
fi

