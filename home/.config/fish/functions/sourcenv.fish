function sourcenv -a file
	cat "$file" | sed -e 's/\(^\|export \)/set -xg /' -e 's/=/ /' | source
end
