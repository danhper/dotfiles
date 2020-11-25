function __venv_activate -a path
    set -l activate_path "$path/bin/activate.fish"
    if test -f $activate_path
        source $activate_path
    else
        echo "venv not found at $path" 1>&2
    end
end

function venv
	set -l cmd $argv[1]
	if test -z "$cmd"
		set cmd activate
	end
	switch $cmd
		case activate
			set -l dir $argv[2]
			if test -z "$path"
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
		case '*'
			echo "Unknown command $cmd"
	end
end
