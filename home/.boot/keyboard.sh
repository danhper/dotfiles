echo "settings layout to us and swapping semicolon" >> $HOME/.logs/boot_setup.log
setxkbmap -layout us,fr -option grp_led:scroll,terminate:ctrl_alt_bksp
xmodmap ~/.xmodmaps/swap_colon_semicolon
xmodmap ~/.xmodmaps/map_alt_to_zenkaku

# When using note keyboard
grep -E "(PFU|HHKB)" /proc/bus/input/devices > /dev/null
if [ $? -eq 1 ]; then
    echo "remapping caps lock" >> $HOME/.logs/boot_setup.log
    xmodmap ~/.xmodmaps/remap_capslock_to_ctrl
fi
