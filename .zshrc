[[ -f ~/.exports ]] && . ~/.exports

which pyenv > /dev/null && eval "$(pyenv init -)"

which rbenv > /dev/null && eval "$(rbenv init -)"

[[ -f ~/.connect_ssh.sh ]] && . ~/.connect_ssh.sh

[[ -f ~/.omzsh-setup ]] && . ~/.omzsh-setup

[[ -f ~/.aliases ]] && . ~/.aliases

