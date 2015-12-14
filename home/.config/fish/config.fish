set plugins_directory $HOME/.config/fish/plugins

set fish_greeting

source $HOME/.config/fish/settings/aliases.fish

source $HOME/.config/fish/plugins.fish

for file in (ls $plugins_directory)
    source "$plugins_directory/$file"
end

set -l sourced \
    "$HOME/.homesick/repos/homeshick/homeshick.fish" \
    "$HOME/.kiex/scripts/kiex.fish"

for file in $sourced
    test -s $file; and source $file
end

fundle init
