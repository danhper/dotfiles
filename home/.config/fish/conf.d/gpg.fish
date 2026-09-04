if status is-interactive
    set -e PINENTRY_USER_DATA
    set -xg GPG_TTY (tty)

    function gpg --wraps gpg
        set -lx PINENTRY_USER_DATA TTY=1
        command gpg $argv
    end

    function git --wraps git
        set -lx PINENTRY_USER_DATA TTY=1
        command git $argv
    end
end
