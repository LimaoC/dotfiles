#!/bin/bash

# Kill existing waybar instance(s) and reopen
# Used for reloading the configuration

killall waybar
sleep 0.5
hyprctl dispatch exec waybar
