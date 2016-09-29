#!/bin/sh

is_env() {
    hdmi_resolution=$1
    vga_resolution=$2
    xrandr | grep -q -E "HDMI1 connected (primary )?$hdmi_resolution"
    hdmi_connected=$?
    xrandr | grep -q "VGA1 connected $vga_resolution"
    vga_connected=$?
    [ $hdmi_connected -eq 0 -a $vga_connected -eq 0 ]
}

is_lab() {
    is_env "1920x1200" "1200x1600"
}

is_office() {
    is_env "1920x1080" "1920x1080"
}

xrandr_output=$(xrandr)
if is_office; then
    export CURRENT_ENV="office"
elif is_lab; then
    export CURRENT_ENV="lab"
else
    export CURRENT_ENV="laptop"
fi
