[[ $- != *i* ]] || ! /usr/bin/tty -s && return
[[ -z "$SSH_CLIENT" ]] && [[ -z "$SSH_TTY" ]] && [[ -z "$TMUX" ]] && exec tmux

[[ -f ~/.homesick/repos/homeshick/homeshick.sh ]] && . ~/.homesick/repos/homeshick/homeshick.sh

[[ -f ~/.connect_ssh.sh ]] && . ~/.connect_ssh.sh

[[ -f ~/.omzsh-setup ]] && . ~/.omzsh-setup

[[ -f ~/.aliases ]] && . ~/.aliases
