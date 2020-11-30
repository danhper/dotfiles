function __venv_activate -a path
	set -l activate_path "$path/bin/activate.fish"
	if test -f $activate_path
		source $activate_path
	else
		echo "venv not found at $path" 1>&2
	end
end

function __venv_has_help
	for arg in $argv
		switch $arg
			case '-h' '--help'
				return 0
		end
	end
	return 1
end

function venv
	set -l cmd $argv[1]
	if test -z "$cmd"
		set cmd activate
	end
	switch $cmd
		case activate
			if __venv_has_help $argv[2..-1]
				echo "usage: venv create [venv-path]"
				return 0
			end
			set -l dir $argv[2]
			if test -z "$dir"
				set dir (venv-helper env-path --quiet)
			end
            __venv_activate $dir
		case create
			set -l create_args $argv[2..-1]
			set -l dir ""
			for arg in $create_args
				switch $arg
					case '-*'
						continue
					case '*'
						set dir $arg
				end
			end
			if test -z "$dir"
				set dir (venv-helper env-path --quiet)
				set -a create_args $dir
			end
			python -m venv $create_args
            __venv_activate $dir
		case destroy
			if __venv_has_help $argv[2..-1]
				echo "usage: venv destroy [venv-path]"
				return 0
			end
			set -l path $argv[2]
			if test -z "$path"
				set path (venv-helper env-path --quiet)
			end
            if test -n "$VIRTUAL_ENV"
                deactivate
            end
			set -l activate_path "$path/bin/activate.fish"
			if test -f $activate_path
				rm -rf $path
			else
				echo "venv not found at $path" 1>&2
			end
        case '-h' '--help'
            echo 'usage: venv [activate | create | destroy] [options]'
		case '*'
			echo "Unknown command $cmd"
	end
end
