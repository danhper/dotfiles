[[ -f ~/.exports ]] && . ~/.exports

which pyenv > /dev/null && eval "$(pyenv init -)"

which rbenv > /dev/null && eval "$(rbenv init -)"

[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

[[ -f ~/.connect_ssh.sh ]] && . ~/.connect_ssh.sh

[[ -f ~/.omzsh-setup ]] && . ~/.omzsh-setup

[[ -f ~/.aliases ]] && . ~/.aliases



# added by travis gem
[ -f /home/daniel/.travis/travis.sh ] && source /home/daniel/.travis/travis.sh


# added by leaves setup.
[[ -f $HOME/.leaves/zsh/leaves-init.sh ]] && . $HOME/.leaves/zsh/leaves-init.sh

