# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

export DEFAULT_USER=daniel
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
#ZSH_THEME="agnoster"
ZSH_THEME="candy"
#ZSH_THEME="wedisagree"



# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias sudo='nocorrect sudo'

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

setopt extended_glob

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git mvn archlinux rails3 ant)

source $ZSH/oh-my-zsh.sh

[[ -f ~/.connect_ssh.sh ]] && . ~/.connect_ssh.sh

# Customize to your needs...
#
pathdirs=(
  /home/daniel/.bin
  /home/daniel/.php53/bin
  /home/daniel/.cabal/bin
  /home/daniel/.mipsel/usr/bin
  /home/daniel/.heroku-client/bin
)

for dir in $pathdirs; do
  if [ -d $dir ]; then
    path+=$dir
  fi
done

export EDITOR=vim
export BROWSER=firefox
export CLASSPATH="."
export NODE_PATH=/usr/lib/node_modules
#export BUNDLE_PATH=~/.gem/ruby/2.0.0/

export PERL_LOCAL_LIB_ROOT="$PERL_LOCAL_LIB_ROOT:/home/daniel/.perl5";
export PERL_MB_OPT="--install_base /home/daniel/.perl5";
export PERL_MM_OPT="INSTALL_BASE=/home/daniel/.perl5";
export PERL5LIB="/home/daniel/.perl5/lib/perl5:$PERL5LIB";
export PATH="/home/daniel/.perl5/bin:$PATH";

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

source ~/.rvm/scripts/rvm
