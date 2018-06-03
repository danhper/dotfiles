function updatevim -d "Update vim plugins"
    set -l command "+BundleInstall"
    if contains -- -f $argv; or contains -- --force $argv
        set command "+BundleInstall!"
    end
    env SHELL=(which sh) vim $command +BundleClean +qall
end
