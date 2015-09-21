if test -z "$TMUX"
  exec tmux
end

set fish_greeting

source $HOME/.config/fish/settings/prompt.fish
source $HOME/.config/fish/settings/completion_helpers.fish
source $HOME/.config/fish/settings/ssh-agent.fish
source $HOME/.config/fish/settings/aliases.fish

source "$HOME/.homesick/repos/homeshick/homeshick.fish"
