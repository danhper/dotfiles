function sourcenv -a file
    if test -z "$file"
        set file .env
    end
    cat "$file" | grep -v '^\s*$' | grep -v '^\s*#' | sed -r -e 's/(^|export )/set -xg /' -e 's/=/ /' | source
end
