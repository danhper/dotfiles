grep "Topre Corporation HHKB Professional" /proc/bus/input/devices > /dev/null
if [ $? -eq 0 ]; then
    setxkbmap -layout us,fr -option grp_led:scroll,terminate:ctrl_alt_bksp
    xmodmap ~/.xmodmaps/map_henkan_to_super
    xmodmap ~/.xmodmaps/map_alt_to_zenkaku
    xmodmap ~/.xmodmaps/swap_colon_semicolon
elif [ "$CURRENT_ENV" = "laptop-vaio-2016" -o "$CURRENT_ENV" = "home" -o "$CURRENT_ENV" = "lab-desktop" ]; then
    echo "settings layout to us and swapping semicolon" >> $HOME/.logs/boot_setup.log
    setxkbmap -layout us,fr -option grp_led:scroll,terminate:ctrl_alt_bksp
    xmodmap ~/.xmodmaps/swap_colon_semicolon
    xmodmap ~/.xmodmaps/map_alt_to_zenkaku
else
    echo "settings layout to jp" >> $HOME/.logs/boot_setup.log
    setxkbmap -layout jp,fr -option grp_led:scroll,terminate:ctrl_alt_bksp
    xmodmap ~/.xmodmaps/remap_henkan_to_fns
fi

# When using note keyboard
grep -E "(PFU|HHKB)" /proc/bus/input/devices > /dev/null
if [ $? -eq 1 ]; then
    echo "remapping caps lock" >> $HOME/.logs/boot_setup.log
    xmodmap ~/.xmodmaps/remap_capslock_to_ctrl
    if [ "$CURRENT_ENV" != "laptop-vaio-2016" -a "$CURRENT_ENV" != "home" ]; then
        echo "remapping up to shift" >> $HOME/.logs/boot_setup.log
        xmodmap ~/.xmodmaps/remap_up_to_shift
    fi
fi

# When using japanese HHKB lite
grep "Chicony PFU-68 USB Keyboard" /proc/bus/input/devices > /dev/null
if [ $? -eq 0 ]; then
    xmodmap ~/.xmodmaps/hhkb_lite
fi

