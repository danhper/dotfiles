#!/bin/sh

is_env() {
    hdmi_resolution=$1
    vga_resolution=$2
    xrandr | grep "HDMI1" -A1 | grep -q "$hdmi_resolution"
    hdmi_connected=$?
    if [ "$vga_resolution" = "false" ]; then
        vga_connected=0
    else
        xrandr | grep "VGA1" -A1 | grep -q "$vga_resolution"
        vga_connected=$?
    fi
    [ $hdmi_connected -eq 0 -a $vga_connected -eq 0 ]
}

is_lab() {
    is_env "1920x1200" "1200x1600" || is_env "1920x1200" "false"
}

is_office() {
    is_env "1920x1080" "1920x1080"
}

if is_office; then
    export CURRENT_ENV="office"
elif is_lab; then
    export CURRENT_ENV="lab"
elif [ -f "$HOME/.current_env" ]; then
    export CURRENT_ENV="$(cat $HOME/.current_env)"
else
    export CURRENT_ENV="laptop"
fi
