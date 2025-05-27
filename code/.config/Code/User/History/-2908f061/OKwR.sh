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

# This script will randomly go through the files of a directory, setting it
# up as the wallpaper at regular intervals
#
# NOTE: this script uses bash (not POSIX shell) for the RANDOM variable

if [[ $# -lt 1 ]] || [[ ! -d $1   ]]; then
	echo "Usage:
	$0 <dir containing images>"
	exit 1
fi

# Edit below to control the images transition
export SWWW_TRANSITION_FPS=144
export SWWW_TRANSITION_STEP=2
export SWWW_TRANSITION_TYPE=random

# This controls (in seconds) when to switch to the next image
INTERVAL=300

while true; do
	find "$1" \
		| while read -r img; do
			echo "$((RANDOM % 1000)):$img"
		done \
		| sort -n | cut -d':' -f2- \
		| while read -r img; do
            if [[ "$img" != "$1" ]]; then
			    swww img "$img"
			    sleep $INTERVAL
            fi 
		done
done