function envio
    if test (count $argv) -eq 0; or contains -- --help $argv; or contains -- -h $argv
        command envio $argv
        return
    end

    set -l profile ""
    if test -f .envio_profile
        set profile (cat .envio_profile)
    else
        set -l profiles (command envio ls --no-pretty-print)
        if test $status -eq 0 -a "$first_profile" != "No profiles found"
            set profile (string split ' ' $first_profile)[1]
        end
    end
    if test -z $profile
        set profile (basename $PWD)
    end

    if test (count $argv) -eq 1; and test $argv[1] = load
        command envio show $profile --no-pretty-print | sed -e 's/^/export /' | source
        return
    end

    if test $argv[1] = create
        if test (count $argv) -eq 2
            set profile $argv[2]
        end
        if not test -d .envio
            command envio init
        end
        ENVIO_KEY=1FEFF6D65203687AC33771CDA0B4CCFEBD33E18A command envio create $profile -k gpg
        return
    end

    if test (count $argv) -eq 2; and test $argv[1] = import; and test -f $argv[2]
        command envio add $profile --envs (grep -ve '^\s*#' -ve '^\s*$' $argv[2])
        return
    end

    if test $argv[1] = show
        if test (count $argv) -eq 3; and test $argv[2] = --key
            command envio show $profile --no-pretty-print | grep $argv[3] | cut -d '=' -f 2
        else if test (count $argv) -ge 2 && not string match -q -- '-*' $argv[2]
            command envio show $argv[2..-1]
        else
            command envio show $profile $argv[2..-1]
        end
        return
    end

    if test $argv[1] = set && test (count $argv) -ge 2
        command envio set $profile $argv[2..-1]
        return
    end


    if test $argv[1] = unset && test (count $argv) -ge 2
        command envio unset $profile $argv[2..-1]
        return
    end

    command envio $argv
end
