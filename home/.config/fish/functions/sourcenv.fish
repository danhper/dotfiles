function sourcenv -a file
	cat "$file" | grep -v '^\s*#' | sed -e 's/\(^\|export \)/set -xg /' -e 's/=/ /' -e 's/\${/{$/g' | source
end
