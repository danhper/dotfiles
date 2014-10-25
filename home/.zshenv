[[ -f ~/.exports ]] && . ~/.exports

which pyenv > /dev/null && eval "$(pyenv init -)"

which rbenv > /dev/null && eval "$(rbenv init -)"

[[ -f ~/.phpbrew/bashrc ]] && . ~/.phpbrew/bashrc

[[ -f ~/.nvm/nvm.sh ]] && . ~/.nvm/nvm.sh
