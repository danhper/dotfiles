function envio
    if test (count $argv) -eq 0; or contains -- --help $argv; or contains -- -h $argv
        command envio $argv
        return
    end

    set -l profile (basename $PWD)
    if test -f .envio
        set profile (cat .envio)
    end

    if test $argv[1] = list; and not contains -- -n $argv; and not contains -- --profile-name $argv; and not contains -- -p $argv; and not contains -- --profiles $argv
        command envio list -n $profile $argv[2..-1]
        return
    end

    if test (count $argv) -eq 1; and test $argv[1] = load
        command envio list --profile-name $profile -v | sed -e 's/^/export /' | source
        return
    end

    if test $argv[1] = create
        if test (count $argv) -eq 2
            set profile $argv[2]
        end
        command envio create $profile -g 1FEFF6D65203687AC33771CDA0B4CCFEBD33E18A
        return
    end

    if test (count $argv) -eq 2; and test $argv[1] = import; and test -f $argv[2]
        command envio add $profile --envs (grep -ve '^\s*#' -ve '^\s*$' $argv[2])
        return
    end

    if test $argv[1] = add; and not contains -- --envs $argv
        if string match '*=*' $argv[2] >/dev/null
            command envio add $profile --envs $argv[2]
        else
            read -s value -p 'echo "value: "'
            command envio add $profile --envs $argv[2]=$value
        end
        return
    end

    if test $argv[1] = show
        if test (count $argv) -eq 2
            command envio list --profile-name $profile -v | grep $argv[2] | cut -d '=' -f 2
            return
        else
            echo "usage: envio show <key>"
            return 1
        end
    end

    if test $argv[1] = remove; and not contains -- -e $argv; and not contains -- --envs-to-remove $argv
        command envio remove $profile --envs-to-remove $argv[2]
        return
    end

    if test $argv[1] = destroy
        if test (count $argv) -eq 2
            set profile $argv[2]
        end
        set -l filepath ~/.envio/profiles/$profile.env
        if not test -f $filepath
            echo "Profile $profile does not exist"
            return 1
        end
        rm $filepath
        return
    end


    command envio $argv
end
