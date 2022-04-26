set base16_dark $HOME/.config/base16-shell/scripts/base16-default-dark.sh
set theme_file $HOME/.cache/theme
set theme "dark"
if test -f $theme_file
    set theme (cat $theme_file)
end

if status --is-interactive; and test -f $base16_dark; and test "$theme" = "dark"
    eval sh $base16_dark
end
