function reverse_isearch
  builtin history --null | eval "fzf --read0 +s --tiebreak=index --toggle-sort=ctrl-r -q (commandline)" | read -z select
  if not test -z $select
    commandline -rb (builtin string trim "$select")
    commandline -f repaint
  end
end
