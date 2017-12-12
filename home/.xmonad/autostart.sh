launch() {
    eval $1 >> ~/.autostart.log 2>&1 &
}

if [ "$CURRENT_ENV" = "lab" -o "$CURRENT_ENV" = "home-desktop" ]; then
    launch "trayer --edge top --align left --margin 1728 --SetDockType true --SetPartialStrut true --expand true --width 192 --widthtype pixel --transparent true --tint 0x000000 --height 23 --alpha 0"
elif [ "$CURRENT_ENV" = "lab-desktop" ]; then
    launch "trayer --edge top --align left --margin 2304 --SetDockType true --SetPartialStrut true --expand true --width 256 --widthtype pixel --transparent true --tint 0x000000 --height 23 --alpha 0"
else
    launch "trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 192 --widthtype pixel --transparent true --tint 0x000000 --height 23 --alpha 0"
fi

launch "devmon"
launch "xcompmgr -c -C -t-5 -l-5 -r4.2 -o.55"
launch "feh --bg-scale ~/.background/amami.jpg"
launch "volumeicon"
launch "xautolock -time 15 -locker slimlock"
launch "pulseaudio --start"
launch "telegram-desktop -startintray"
launch "nm-applet"
launch "twmnd"
launch "emacs --daemon"
launch "albert"
sleep 3
launch "dropbox"
