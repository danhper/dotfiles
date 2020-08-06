function sourcenv -a file
	if test -z "$file"
		set file .env
	end
	cat "$file" | grep -v '^\s*#' | sed -e 's/\(^\|export \)/set -xg /' -e 's/=/ /' -e 's/\${/{$/g' | source
end
