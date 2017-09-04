set fish_greeting

set -l sourced \
    "$HOME/.homesick/repos/homeshick/homeshick.fish"

for file in $sourced
    test -s $file; and source $file
end

fundle init
