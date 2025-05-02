#!/usr/bin/env bash

# This script sets a random wallpaper from the user's local wallpapers directory
# and applies a Gaussian blur effect to it, saving the result as /tmp/lockscreen.png.
# It uses the `magick` command from ImageMagick to perform the image processing.

wallpaper_choice=$(find $HOME/.dotfiles/.local/share/wallpapers -type f | shuf -n 1)

cp $wallpaper_choice $HOME/.local/share/wallpapers/tmp/wallpaper.png
cp $wallpaper_choice /usr/share/sddm/tmp/wallpaper.png

/usr/bin/magick $HOME/.local/share/wallpapers/tmp/wallpaper.png -filter Gaussian -resize 20% -blur 0x2.5 /tmp/lockscreen.png

swaymsg output "*" bg $HOME/.local/share/wallpapers/tmp/wallpaper.png fill