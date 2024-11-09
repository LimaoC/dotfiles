#!/bin/bash

# Usage: ./install-dotfiles.sh [--clean]

# NOTE: This install script assumes that it is in a subdirectory
# NOTE: in ~, e.g. ~/.dotfiles. This is so that the config files
# NOTE: can be correctly symlinked to the parent directory ~.
# NOTE: For more info, see `man stow`

dirs=(
    "git"
    "kitty"
    "misc"
    "nvim"
    "vim"

    # "bash"
    "zsh"

    "hypr"
    "waybar"
    "wlogout"
    "wofi"

    # "conda"
    "zathura"
)

if [ -z "$1" ]; then
    for dir in "${dirs[@]}"; do
        stow --verbose=1 $dir
    done
elif [[ "$1" == "--clean" ]]; then
    for dir in "${dirs[@]}"; do
        stow --verbose=1 -D $dir
    done
else
    echo "install-dotfiles: Unknown argument: $1"
fi
