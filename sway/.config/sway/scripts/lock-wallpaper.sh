#!/usr/bin/env bash

# This script sets a random wallpaper from the user's local wallpapers directory
# and applies a Gaussian blur effect to it, saving the result as /tmp/lockscreen.png.
# It uses the `magick` command from ImageMagick to perform the image processing.

wallpaper_choice=$(find ~/.dotfiles/wallpapers -type f | shuf -n 1)

cp $wallpaper_choice $HOME/.local/share/wallpapers/tmp/wallpaper.png
cp $wallpaper_choice /usr/share/sddm/tmp/wallpaper.png

/usr/bin/magick $wallpaper_choice -filter Gaussian -resize 20% -blur 2x20 /tmp/lockscreen.png

# export WAYLAND_DISPLAY="wayland-1"
~/.nix-profile/bin/swww query || ~/.nix-profile/bin/swww-daemon
~/.nix-profile/bin/swww img $wallpaper_choice