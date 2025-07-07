complete -c envio -n "__fish_use_subcommand" -s h -l help -d 'Print help'
complete -c envio -n "__fish_use_subcommand" -f -a "create" -d 'Create a new profile'
complete -c envio -n "__fish_use_subcommand" -f -a "add" -d 'Add envionment variables to a profile'
complete -c envio -n "__fish_use_subcommand" -f -a "show" -d 'Show a specific environment variable from a profile'
complete -c envio -n "__fish_use_subcommand" -f -a "load" -d 'Load all environment variables in a profile for use in your terminal sessions'
complete -c envio -n "__fish_seen_subcommand_from add" -f -a "(envio list -p -v)"
complete -c envio -n "__fish_seen_subcommand_from load" -f -a "(envio list -p -v)"
complete -c envio -n "__fish_use_subcommand" -f -a "unload" -d 'Unload a profile'
complete -c envio -n "__fish_use_subcommand" -f -a "launch" -d 'Run a command with the environment variables from a profile'
complete -c envio -n "__fish_use_subcommand" -f -a "remove" -d 'Remove a environment variable from a profile'
complete -c envio -n "__fish_use_subcommand" -f -a "list" -d 'List all the environment variables in a profile or all the profiles currenty stored'
complete -c envio -n "__fish_use_subcommand" -f -a "update" -d 'Update environment variables in a profile'
complete -c envio -n "__fish_use_subcommand" -f -a "export" -d 'Export a profile to a file if no file is specified it will be exported to a file named .env'
complete -c envio -n "__fish_use_subcommand" -f -a "import" -d 'Download a profile over the internet and import it into the system or import a locally stored profile into your current envio installation'
complete -c envio -n "__fish_use_subcommand" -f -a "version" -d 'Print the version'
complete -c envio -n "__fish_use_subcommand" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c envio -n "__fish_seen_subcommand_from create" -s f -l file-to-import-envs-from -r
complete -c envio -n "__fish_seen_subcommand_from create" -s e -l envs -r
complete -c envio -n "__fish_seen_subcommand_from create" -s g -l gpg-key-fingerprint -r
complete -c envio -n "__fish_seen_subcommand_from create" -s c -l add-comments
complete -c envio -n "__fish_seen_subcommand_from create" -s x -l add-expiration-date
complete -c envio -n "__fish_seen_subcommand_from create" -s h -l help -d 'Print help'
complete -c envio -n "__fish_seen_subcommand_from add" -s e -l envs -r
complete -c envio -n "__fish_seen_subcommand_from add" -s c -l add-comments
complete -c envio -n "__fish_seen_subcommand_from add" -s x -l add-expiration-date
complete -c envio -n "__fish_seen_subcommand_from add" -s h -l help -d 'Print help'
complete -c envio -n "__fish_seen_subcommand_from load" -s h -l help -d 'Print help'
complete -c envio -n "__fish_seen_subcommand_from show" -f -a "(envio list -v | cut -d '=' -f 1)"
complete -c envio -n "__fish_seen_subcommand_from unload" -s h -l help -d 'Print help'
complete -c envio -n "__fish_seen_subcommand_from launch" -s c -l command -r
complete -c envio -n "__fish_seen_subcommand_from launch" -s h -l help -d 'Print help'
complete -c envio -n "__fish_seen_subcommand_from remove" -s e -l envs-to-remove -r
complete -c envio -n "__fish_seen_subcommand_from remove" -f -a "(envio list -p -v)"
complete -c envio -n "__fish_seen_subcommand_from remove" -s h -l help -d 'Print help'
complete -c envio -n "__fish_seen_subcommand_from list; and not __fish_prev_arg_in -n --profile-name" -s n -l profile-name -r
complete -c envio -n "__fish_seen_subcommand_from list; and not __fish_prev_arg_in -n --profile-name" -s p -l profiles
complete -c envio -n "__fish_seen_subcommand_from list; and not __fish_prev_arg_in -n --profile-name" -s v -l no-pretty-print
complete -c envio -n "__fish_seen_subcommand_from list; and not __fish_prev_arg_in -n --profile-name" -s c -l display-comments
complete -c envio -n "__fish_seen_subcommand_from list; and not __fish_prev_arg_in -n --profile-name" -s x -l display-expiration-date
complete -c envio -n "__fish_seen_subcommand_from list; and not __fish_prev_arg_in -n --profile-name" -s h -l help -d 'Print help'
complete -c envio -n "__fish_seen_subcommand_from list; and __fish_contains_opt -s n profile-name" -f -a "(envio list -p -v)"
complete -c envio -n "__fish_seen_subcommand_from update" -s e -l envs -r
complete -c envio -n "__fish_seen_subcommand_from update" -s v -l update-values
complete -c envio -n "__fish_seen_subcommand_from update" -s c -l update-comments
complete -c envio -n "__fish_seen_subcommand_from update" -s x -l update-expiration-date
complete -c envio -n "__fish_seen_subcommand_from update" -s h -l help -d 'Print help'
complete -c envio -n "__fish_seen_subcommand_from export" -s f -l file-to-export-to -r
complete -c envio -n "__fish_seen_subcommand_from export" -s e -l envs -r
complete -c envio -n "__fish_seen_subcommand_from export" -s h -l help -d 'Print help'
complete -c envio -n "__fish_seen_subcommand_from import" -s f -l file-to-import-from -r
complete -c envio -n "__fish_seen_subcommand_from import" -s u -l url -r
complete -c envio -n "__fish_seen_subcommand_from import" -s h -l help -d 'Print help'
complete -c envio -n "__fish_seen_subcommand_from version" -s v -l verbose
complete -c envio -n "__fish_seen_subcommand_from version" -s h -l help -d 'Print help'
complete -c envio -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from add; and not __fish_seen_subcommand_from load; and not __fish_seen_subcommand_from unload; and not __fish_seen_subcommand_from launch; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from list; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from export; and not __fish_seen_subcommand_from import; and not __fish_seen_subcommand_from version; and not __fish_seen_subcommand_from help" -f -a "create" -d 'Create a new profile'
complete -c envio -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from add; and not __fish_seen_subcommand_from load; and not __fish_seen_subcommand_from unload; and not __fish_seen_subcommand_from launch; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from list; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from export; and not __fish_seen_subcommand_from import; and not __fish_seen_subcommand_from version; and not __fish_seen_subcommand_from help" -f -a "add" -d 'Add envionment variables to a profile'
complete -c envio -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from add; and not __fish_seen_subcommand_from load; and not __fish_seen_subcommand_from unload; and not __fish_seen_subcommand_from launch; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from list; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from export; and not __fish_seen_subcommand_from import; and not __fish_seen_subcommand_from version; and not __fish_seen_subcommand_from help" -f -a "load" -d 'Load all environment variables in a profile for use in your terminal sessions'
complete -c envio -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from add; and not __fish_seen_subcommand_from load; and not __fish_seen_subcommand_from unload; and not __fish_seen_subcommand_from launch; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from list; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from export; and not __fish_seen_subcommand_from import; and not __fish_seen_subcommand_from version; and not __fish_seen_subcommand_from help" -f -a "unload" -d 'Unload a profile'
complete -c envio -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from add; and not __fish_seen_subcommand_from load; and not __fish_seen_subcommand_from unload; and not __fish_seen_subcommand_from launch; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from list; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from export; and not __fish_seen_subcommand_from import; and not __fish_seen_subcommand_from version; and not __fish_seen_subcommand_from help" -f -a "launch" -d 'Run a command with the environment variables from a profile'
complete -c envio -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from add; and not __fish_seen_subcommand_from load; and not __fish_seen_subcommand_from unload; and not __fish_seen_subcommand_from launch; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from list; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from export; and not __fish_seen_subcommand_from import; and not __fish_seen_subcommand_from version; and not __fish_seen_subcommand_from help" -f -a "remove" -d 'Remove a environment variable from a profile'
complete -c envio -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from add; and not __fish_seen_subcommand_from load; and not __fish_seen_subcommand_from unload; and not __fish_seen_subcommand_from launch; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from list; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from export; and not __fish_seen_subcommand_from import; and not __fish_seen_subcommand_from version; and not __fish_seen_subcommand_from help" -f -a "list" -d 'List all the environment variables in a profile or all the profiles currenty stored'
complete -c envio -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from add; and not __fish_seen_subcommand_from load; and not __fish_seen_subcommand_from unload; and not __fish_seen_subcommand_from launch; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from list; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from export; and not __fish_seen_subcommand_from import; and not __fish_seen_subcommand_from version; and not __fish_seen_subcommand_from help" -f -a "update" -d 'Update environment variables in a profile'
complete -c envio -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from add; and not __fish_seen_subcommand_from load; and not __fish_seen_subcommand_from unload; and not __fish_seen_subcommand_from launch; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from list; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from export; and not __fish_seen_subcommand_from import; and not __fish_seen_subcommand_from version; and not __fish_seen_subcommand_from help" -f -a "export" -d 'Export a profile to a file if no file is specified it will be exported to a file named .env'
complete -c envio -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from add; and not __fish_seen_subcommand_from load; and not __fish_seen_subcommand_from unload; and not __fish_seen_subcommand_from launch; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from list; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from export; and not __fish_seen_subcommand_from import; and not __fish_seen_subcommand_from version; and not __fish_seen_subcommand_from help" -f -a "import" -d 'Download a profile over the internet and import it into the system or import a locally stored profile into your current envio installation'
complete -c envio -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from add; and not __fish_seen_subcommand_from load; and not __fish_seen_subcommand_from unload; and not __fish_seen_subcommand_from launch; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from list; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from export; and not __fish_seen_subcommand_from import; and not __fish_seen_subcommand_from version; and not __fish_seen_subcommand_from help" -f -a "version" -d 'Print the version'
complete -c envio -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from add; and not __fish_seen_subcommand_from load; and not __fish_seen_subcommand_from unload; and not __fish_seen_subcommand_from launch; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from list; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from export; and not __fish_seen_subcommand_from import; and not __fish_seen_subcommand_from version; and not __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
