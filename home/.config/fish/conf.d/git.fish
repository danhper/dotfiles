function glg;   git log --stat --color $argv; end
function glgga; git log --graph --decorate --all $argv; end

abbr -a g 'git'
abbr -a gst 'git status'
abbr -a ga 'git add'
abbr -a gco 'git checkout'
abbr -a gd 'git diff'
abbr -a gdc 'git diff --cached'
abbr -a gc 'git commit'
abbr -a gp 'git push'
abbr -a gl 'git pull'
abbr -a gb 'git branch'
abbr -a gm 'git merge'

function gcm
    git checkout master > /dev/null 2>&1 || git checkout main
end
