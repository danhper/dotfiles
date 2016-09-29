export XIM=ibus
export GTK_IM_MODULE="ibus"
export QT_IM_MODULE="ibus"
export XMODIFIERS="@im=ibus"
ibus-daemon --xim -r -v >> ~/.autostart.log 2>&1 &
