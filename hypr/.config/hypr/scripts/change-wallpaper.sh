#!/bin/bash

# Opens wallpaper selector with wofi and loads selected wallpaper
# Changes colour theme based on wallpaper using wal
# REF: https://github.com/hyprwm/hyprpaper/issues/108

source $HOME/.config/hypr/scripts/variables.sh

if [[ ! -d "$WALLPAPERS_DIR" ]] then
    exit 1
fi

new_wallpaper=$WALLPAPERS_DIR/$(ls $WALLPAPERS_DIR | wofi --dmenu)

# Check if a wallpaper was actually selected
if [[ $? -ne 0 ]] then
    exit 1
fi

# Save wallpaper to cache (see scripts/load-wallpaper-from-cache.sh)
ln -s -f $new_wallpaper $WALLPAPER_CACHE

# Regenerate colour scheme
# I've installed pywal through pipx so it's located at ~/.local/bin
~/.local/bin/wal -q -s -i $new_wallpaper

# Set new wallpaper with hyprpaper
hyprctl hyprpaper unload all
hyprctl hyprpaper preload $new_wallpaper
hyprctl hyprpaper wallpaper ", $new_wallpaper"

# Reload waybar
bash ~/.config/hypr/scripts/reload-waybar.sh
