#!/usr/bin/env bash

# This script sets a random wallpaper from the user's local wallpapers directory
# and applies a Gaussian blur effect to it, saving the result as /tmp/lockscreen.png.
# It uses the `magick` command from ImageMagick to perform the image processing.

wallpaper_choice=$(find ~/.dotfiles/wallpapers -type f | shuf -n 1)

cp $wallpaper_choice /tmp/wallpaper.png
# cp $wallpaper_choice /usr/share/sddm/tmp/wallpaper.png

magick $wallpaper_choice -filter Gaussian -resize 20% -blur 2x20 /tmp/lockscreen.png

export WAYLAND_DISPLAY="wayland-1"

if ! pgrep -x swww-daemon > /dev/null; then
    swww-daemon &
fi

swww img /tmp/wallpaper.png