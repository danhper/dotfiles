setxkbmap -layout jp,fr -option grp_led:scroll,terminate:ctrl_alt_bksp
xmodmap ~/.Xmodmap

# When using note keyboard
grep "PFU" /proc/bus/input/devices > /dev/null
if [ $? -eq 1 ]; then
    xmodmap ~/.upmodmap
    xmodmap ~/.capsmodmap
fi

# When using japanese HHKB lite
grep "Chicony PFU-68 USB Keyboard" /proc/bus/input/devices > /dev/null
if [ $? -eq 0 ]; then
    xmodmap ~/.hhkb_lite_xmodmap
fi

