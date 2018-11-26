function sourcenv -a file
	cat "$file" | sed -e 's/\(^\|export \)/set -xg /' -e 's/=/ /' -e 's/\${/{$/g' | source
end
