launch() {
    eval $1 >> ~/.autostart.log 2>&1 &
}

if [ "$CURRENT_ENV" = "lab" ]; then
    launch "trayer --edge top --align left --margin 1728 --SetDockType true --SetPartialStrut true --expand true --width 192 --widthtype pixel --transparent true --tint 0x000000 --height 22 --alpha 0"
else
    launch "trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 192 --widthtype pixel --transparent true --tint 0x000000 --height 22 --alpha 0"
fi

launch "devmon"
launch "xcompmgr -c -C -t-5 -l-5 -r4.2 -o.55"
launch "feh --bg-scale ~/.background/amami.jpg"
launch "pnmixer"
launch "xautolock -time 15 -locker slimlock"
launch "pulseaudio --start"
launch "hexchat --minimize=2"
launch "nm-applet"
launch "twmnd"
launch "owncloud"
launch "emacs --daemon"
launch "mutate --hidden"
sleep 3
launch "dropbox"
