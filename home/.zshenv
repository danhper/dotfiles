[[ -f ~/.exports ]] && . ~/.exports

which pyenv > /dev/null && eval "$(pyenv init - --no-rehash)"

which rbenv > /dev/null && eval "$(rbenv init - --no-rehash)"

[[ -f ~/.phpbrew/bashrc ]] && . ~/.phpbrew/bashrc

[[ -f ~/.nvm/nvm.sh ]] && . ~/.nvm/nvm.sh

[[ -f ~/.kiex/scripts/kiex ]] && . ~/.kiex/scripts/kiex

[[ -f ~/.gimme/envs/latest.env ]] && . ~/.gimme/envs/latest.env
