function __venv_export_eval --on-variable PWD;
	set -l current_path $VIRTUAL_ENV
	set -l desired_path (venv-helper env-path --quiet)
	if test $status -eq 1 
		if test -n "$VIRTUAL_ENV"
			deactivate
		end
	else
		if test -z "$VIRTUAL_ENV"
			source "$desired_path/bin/activate.fish"
		else
			if test $VIRTUAL_ENV != $desired_path
				deactivate
				source "$desired_path/bin/activate.fish"
			end
		end
	end
end
__venv_export_eval 
