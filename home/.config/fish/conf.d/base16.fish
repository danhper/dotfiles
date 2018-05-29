set base16_dark $HOME/.config/base16-shell/scripts/base16-default-dark.sh
if status --is-interactive; and test -f $base16_dark
    eval sh $base16_dark
end
