rm $HOME/.logs/boot_setup.log
[[ -f ~/.boot/setenv.sh ]] && . ~/.boot/setenv.sh
[[ -f ~/.boot/xorg.sh ]] && . ~/.boot/xorg.sh
[[ -f ~/.boot/keyboard.sh ]] && . ~/.boot/keyboard.sh
[[ -f ~/.boot/ime.sh ]] && . ~/.boot/ime.sh
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

xset -dpms
xset s off
xsetroot -cursor_name left_ptr

case "$1" in
     lxde)
        exec startlxde ;;
     xmonad|*)
        [[ -f ~/.xmonad/autostart.sh ]] && . ~/.xmonad/autostart.sh
        exec stack exec -- xmonad ;;
esac
