alias du='command du -sh'
alias df='command df -h'
alias bi='bundle install'
alias be='bundle exec'
alias package_sizes='expac "%m\t%n" | sort -h | awk '\''{ printf("%-35s %dM\n", $2, $1 / 1024 / 1024) }'\'
alias ch='google-chrome-stable'
alias sl='ls'
alias v='vim'
alias s='subl'
alias py='python'
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
alias e='emacsclient -c -a emacs'
alias _='sudo'
