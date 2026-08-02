#!/usr/bin/bash

pgrep -x awww-daemon > /dev/null || awww-daemon &
sleep 1

# Landscape (DP-1) and portrait (DP-2) get set independently via --outputs.
# To try a different combo, just swap the paths below.
awww img ~/Pictures/wallpapers/guts_pakku_walking_light.jpg --outputs DP-1
awww img ~/Pictures/wallpapers/swords_portrait.jpg --outputs DP-2
