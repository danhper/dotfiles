grep "Topre Corporation HHKB Professional" /proc/bus/input/devices > /dev/null
if [ $? -eq 0 ]; then
    setxkbmap -layout us,fr -option grp_led:scroll,terminate:ctrl_alt_bksp
    xmodmap ~/.xmodmaps/map_henkan_to_super
    xmodmap ~/.xmodmaps/map_alt_to_zenkaku
    xmodmap ~/.xmodmaps/swap_colon_semicolon
else
    setxkbmap -layout jp,fr -option grp_led:scroll,terminate:ctrl_alt_bksp
    xmodmap ~/.xmodmaps/remap_henkan_to_fns
fi

# When using note keyboard
grep -E "(PFU|HHKB)" /proc/bus/input/devices > /dev/null
if [ $? -eq 1 ]; then
    xmodmap ~/.xmodmaps/remap_up_to_shift
    xmodmap ~/.xmodmaps/remap_capslock_to_ctrl
fi

# When using japanese HHKB lite
grep "Chicony PFU-68 USB Keyboard" /proc/bus/input/devices > /dev/null
if [ $? -eq 0 ]; then
    xmodmap ~/.xmodmaps/hhkb_lite
fi

