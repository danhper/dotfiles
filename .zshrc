[[ -f ~/.exports ]] && . ~/.exports

[[ -f ~/.rvm/scripts/rvm ]] && . ~/.rvm/scripts/rvm

which pyenv > /dev/null && eval "$(pyenv init -)"

[[ -f ~/.connect_ssh.sh ]] && . ~/.connect_ssh.sh

[[ -f ~/.omzsh-setup ]] && . ~/.omzsh-setup

[[ -f ~/.aliases ]] && . ~/.aliases

