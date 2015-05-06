[[ $- != *i*  ]] && return
[[ -z "$TMUX"  ]] && exec tmux

[[ -f ~/.homesick/repos/homeshick/homeshick.sh ]] && . ~/.homesick/repos/homeshick/homeshick.sh

[[ -f ~/.connect_ssh.sh ]] && . ~/.connect_ssh.sh

[[ -f ~/.omzsh-setup ]] && . ~/.omzsh-setup

[[ -f ~/.aliases ]] && . ~/.aliases

# added by leaves setup.
[[ -f $HOME/.leaves/zsh/leaves-init.sh ]] && . $HOME/.leaves/zsh/leaves-init.sh
