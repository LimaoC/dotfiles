#!/bin/bash

# Enable laptop screen if lid is open, disable otherwise

cat /proc/acpi/button/lid/LID0/state | grep "open"

if [ $? -eq 0 ]; then
    hyprctl keyword monitor "eDP-1, preferred, 0x0, 1"
else
    hyprctl keyword monitor "eDP-1, disable"
fi
