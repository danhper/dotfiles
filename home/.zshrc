[[ $- != *i*  ]] && return
[[ -z "$TMUX"  ]] && exec tmux

[[ -f ~/.homesick/repos/homeshick/homeshick.sh ]] && . ~/.homesick/repos/homeshick/homeshick.sh

[[ -f ~/.connect_ssh.sh ]] && . ~/.connect_ssh.sh

[[ -f ~/.omzsh-setup ]] && . ~/.omzsh-setup

[[ -f ~/.aliases ]] && . ~/.aliases

# added by leaves setup.
[[ -f $HOME/.leaves/zsh/leaves-init.sh ]] && . $HOME/.leaves/zsh/leaves-init.sh

# added by ohh setup
[[ -f $HOME/.ohh/zsh/ohh-init.sh ]] && . $HOME/.ohh/zsh/ohh-init.sh

# added by travis gem
[ -f /home/daniel/.travis/travis.sh ] && source /home/daniel/.travis/travis.sh
