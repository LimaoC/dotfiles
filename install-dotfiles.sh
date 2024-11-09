#!/bin/bash

# NOTE: This install script assumes that it is in a subdirectory
# NOTE: in ~, e.g. ~/.dotfiles. This is so that the config files
# NOTE: can be correctly symlinked to the parent directory ~.
# NOTE: For more info, see `man stow`

stow_cmd="stow --verbose=1"

$stow_cmd git
$stow_cmd kitty
$stow_cmd misc
$stow_cmd nvim
$stow_cmd vim

# $stow_cmd bash
$stow_cmd zsh

$stow_cmd hypr
$stow_cmd waybar
$stow_cmd wlogout

# $stow_cmd conda
# $stow_cmd zathura

