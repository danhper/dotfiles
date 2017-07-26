set confd_dir "$HOME/.config/fish/conf.d"

set fish_greeting

source $HOME/.config/fish/settings/aliases.fish

source $HOME/.config/fish/plugins.fish

for file in (ls "$confd_dir")
    source "$confd_dir/$file"
end

set -l sourced \
    "$HOME/.homesick/repos/homeshick/homeshick.fish"

for file in $sourced
    test -s $file; and source $file
end

fundle init
