[[ -f ~/.exports ]] && . ~/.exports

which pyenv > /dev/null && eval "$(pyenv init - --no-rehash)"

[[ -f ~/.phpbrew/bashrc ]] && . ~/.phpbrew/bashrc
