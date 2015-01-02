[[ -f ~/.setxorg.sh ]] && . ~/.setxorg.sh
[[ -f ~/.keyboard_setup.sh ]] && . ~/.keyboard_setup.sh
[[ -f ~/.ime_setup.sh ]] && . ~/.ime_setup.sh
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

xset -dpms
xset s off
xsetroot -cursor_name left_ptr

case "$1" in
     lxde)
        exec startlxde ;;
     xmonad|*)
        [[ -f ~/.xmonad/autostart.sh ]] && . ~/.xmonad/autostart.sh
        exec xmonad ;;
esac
