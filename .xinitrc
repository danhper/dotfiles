[[ -f ~/.setscreen.sh ]] && . ~/.setscreen.sh

export XIM=ibus
export XIM_PROGRAM=/usr/bin/ibus-daemon
export XIM_ARGS="--xim"
export GTK_IM_MODULE="ibus"
export QT_IM_MODULE="ibus"
export XMODIFIERS="@im=ibus"

setxkbmap -layout jp,fr -option grp:shift_toggle,grp_led:scroll,terminate:ctrl_alt_bksp

xset -dpms
xset s off

xmodmap ~/.Xmodmap
grep "PFU" /proc/bus/input/devices > /dev/null
if [ $? -eq 1 ]; then
    xmodmap ~/.upmodmap
    xmodmap ~/.capsmodmap
fi

exec startlxde
