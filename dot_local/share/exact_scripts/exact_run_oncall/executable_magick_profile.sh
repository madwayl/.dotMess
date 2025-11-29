#!/bin/bash

magick $1 -gravity center -crop 1:1 -resize 150x150 $HOME/Pictures/wallpaper-square-nb.png &
magick $1 -gravity center -crop 1:1 -resize 150x150 -border 12%x12% -bordercolor "$2" $HOME/Pictures/wallpaper-square.png &

dms ipc call profile setImage $HOME/Pictures/wallpaper-square-nb.png
