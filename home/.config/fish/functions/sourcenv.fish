function sourcenv -a file
    if test -z "$file"
        set file .env
    end

    if not test -f "$file"
        echo "sourcenv: $file: No such file" >&2
        return 1
    end

    set -l line_number 0
    while read -l line; or test -n "$line"
        set line_number (math $line_number + 1)
        set -l trimmed (string trim -- "$line")

        if test -z "$trimmed"; or string match -qr '^#' -- "$trimmed"
            continue
        end

        set -l assignment (string replace -r '^export[[:space:]]+' '' -- "$trimmed")
        set -l parts (string split -m1 = -- "$assignment")

        if test (count $parts) -ne 2
            echo "sourcenv: $file:$line_number: expected KEY=VALUE" >&2
            return 1
        end

        set -l key (string trim -- "$parts[1]")
        set -l value (string trim -- "$parts[2]")
        set -l expand_vars 1

        if not string match -qr '^[A-Za-z_][A-Za-z0-9_]*$' -- "$key"
            echo "sourcenv: $file:$line_number: invalid variable name '$key'" >&2
            return 1
        end

        if string match -qr '^".*"$' -- "$value"
            set value (string replace -r '^"(.*)"$' '$1' -- "$value")
        else if string match -qr "^'.*'\$" -- "$value"
            set value (string replace -r "^'(.*)'\$" '$1' -- "$value")
            set expand_vars 0
        end

        if test $expand_vars -eq 1
            for ref in (string match -ra '\$\{?[A-Za-z_][A-Za-z0-9_]*\}?' -- "$value")
                set -l name (string replace -r '^\$\{?([A-Za-z_][A-Za-z0-9_]*)\}?$' '$1' -- "$ref")
                set -l replacement (string join ' ' -- $$name)
                set value (string replace -a -- "$ref" "$replacement" "$value")
            end
        end

        set -gx $key "$value"
    end < "$file"
end
