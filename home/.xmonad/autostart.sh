launch() {
    eval $1 >> ~/.autostart.log 2>&1 &
}

launch "trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 150 --widthtype pixel --transparent true --tint 0x000000 --height 20 --alpha 0"
launch "devmon"
launch "xcompmgr -c -C -t-5 -l-5 -r4.2 -o.55"
launch "feh --bg-scale ~/.background/skyward.jpg"
launch "pnmixer"
launch "xautolock -time 15 -locker slimlock"
launch "pulseaudio --start"
launch "nm-applet"
launch "owncloud"
sleep 3
launch "dropbox"
