function venv -a env
	if test -z "$env"
		set env .venv
	end
	source "$env/bin/activate.fish"
end
