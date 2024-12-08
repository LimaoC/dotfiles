#!/bin/bash

# Loads wallpaper from cache, so that wallpaper changes are preserved on startup.
# Defaults to fallback wallpaper if there is no cached wallpaper
# Unlike change-wallpaper.sh, colour schemes & other programs etc. are not reloaded,
# since this is intended to be run at start-up only.

sleep 0.5

source $HOME/.config/hypr/scripts/variables.sh

# Set default fallback wallpaper
default_wallpaper=$WALLPAPERS_DIR/1090642.jpg

if [[ ! -f $WALLPAPER_CACHE ]] then
    wallpaper=$default_wallpaper
else
    wallpaper=$WALLPAPER_CACHE
fi

echo $wallpaper >> /tmp/log.txt

# Set new wallpaper with hyprpaper
hyprctl hyprpaper unload all >> /tmp/log.txt 2>&1
hyprctl hyprpaper preload $wallpaper >> /tmp/log.txt 2>&1
hyprctl hyprpaper wallpaper ", $wallpaper" >> /tmp/log.txt 2>&1

