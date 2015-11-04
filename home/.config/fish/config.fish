if test -z "$TMUX"
  exec tmux
end

set plugins_directory $HOME/.config/fish/plugins

set fish_greeting

source $HOME/.config/fish/settings/prompt.fish
source $HOME/.config/fish/settings/completion_helpers.fish
source $HOME/.config/fish/settings/ssh-agent.fish
source $HOME/.config/fish/settings/aliases.fish

source $HOME/.config/fish/plugins.fish

for file in (ls $plugins_directory)
  source "$plugins_directory/$file"
end

source "$HOME/.homesick/repos/homeshick/homeshick.fish"

fundle init
