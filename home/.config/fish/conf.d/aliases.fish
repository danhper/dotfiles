alias du='du -h'
alias df='df -h'
alias package_sizes='expac "%m\t%n" | sort -h | awk '\''{ printf("%-35s %dM\n", $2, $1 / 1024 / 1024) }'\'
alias ch='google-chrome-stable'
alias sl='ls'
alias v='nvim'
alias py='python'
alias pbcopy='wl-copy'
alias pbpaste='wl-paste'
alias em="emacsclient -nc"
alias emt="emacsclient -t -c -a ''"
alias gcal='gcalcli'

abbr -a bi 'bundle install'
abbr -a be 'bundle exec'
abbr -a so sudo
