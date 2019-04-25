alias du='du -h'
alias df='df -h'
alias package_sizes='expac "%m\t%n" | sort -h | awk '\''{ printf("%-35s %dM\n", $2, $1 / 1024 / 1024) }'\'
alias ch='google-chrome-stable'
alias sl='ls'
alias v='vim'
alias py='python'
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
alias e='emacsclient -c -a emacs'
alias gcal='gcalcli'
alias clojure='rlwrap java -cp ~/.m2/repository/org/clojure/clojure/1.8.0/clojure-1.8.0.jar clojure.main'

if test -f ~/.local/share/avro/avro-tools-1.7.7.jar
  alias avro="java -jar ~/.local/share/avro/avro-tools-1.7.7.jar"
end
if test -f ~/.local/share/avro/avrocount-0.4.0.jar
  alias avro-count="java -jar ~/.local/share/avro/avrocount-0.4.0.jar"
end

abbr -a bi 'bundle install'
abbr -a be 'bundle exec'
abbr -a so 'sudo'
