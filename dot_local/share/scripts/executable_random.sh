#!/usr/bin/env bash

filename=$(basename "$2")
COLOR=$(jq --arg f "$filename" -r '.[$f]' $XDG_DATA_HOME/scripts/opts/image-color.json)
TEMPLATE_PATH=" $XDG_DATA_HOME/scripts/templates/"

case "$COLOR" in
    "red")
        ICON_COLOR="Adwaita-red"
        THEME="Orchis-Red-Dark"
        COLOR_C=red
        COLOR_HEX="#cc241d"
        COLOR_M_HEX="#f2594b"
        BG_COLOR_HEX="#3c1f1e"
        terminal_color="\033[38;5;167m"
        terminal_bg_color="\033[38;5;52m"
        cbonsai_list="52,130,124,94"
        ;;

    "gray")
        ICON_COLOR="Adwaita-slate"
        THEME="Orchis-Grey-Dark"
        COLOR_C=gray
        COLOR_HEX="#a89984"
        COLOR_M_HEX="#e2cca9"
        BG_COLOR_HEX="#4a4640"
        terminal_color="\033[38;5;245m"
        terminal_bg_color="\033[38;5;239m"
        cbonsai_list="237,130,245,94"
        ;;

    "green")
        ICON_COLOR="Adwaita-green"
        THEME="Orchis-Green-Dark"
        COLOR_C=green
        COLOR_HEX="#98971a"
        COLOR_M_HEX="#b0b846"
        BG_COLOR_HEX="#32361a"
        terminal_color="\033[38;5;142m"
        terminal_bg_color="\033[38;5;22m"
        cbonsai_list="22,130,142,94"
        ;;

    "orange")
        ICON_COLOR="Adwaita-orange"
        THEME="Orchis-Orange-Dark"
        COLOR_C=yellow
        COLOR_HEX="#f28534"
        COLOR_M_HEX="#f28534"
        BG_COLOR_HEX="#4a2e1a"
        terminal_color="\033[38;5;208m"
        terminal_bg_color="\033[38;5;94m"
        cbonsai_list="166,130,208,94"
        ;;

    "yellow")
        ICON_COLOR="Adwaita-yellow"
        THEME="Orchis-Yellow-Dark"
        COLOR_C=yellow
        COLOR_HEX="#d79921"
        COLOR_M_HEX="#e9b143"
        BG_COLOR_HEX="#3f3518"
        terminal_color="\033[38;5;214m"
        terminal_bg_color="\033[38;5;136m"
        cbonsai_list="136,130,229,94"
        ;;

    "teal")
        ICON_COLOR="Adwaita-teal"
        THEME="Orchis-Teal-Dark"
        COLOR_C=cyan
        COLOR_HEX="#689d6a"
        COLOR_M_HEX="#8bba7f"
        BG_COLOR_HEX="#1e352d"
        terminal_color="\033[38;5;108m"
        terminal_bg_color="\033[38;5;23m"
        cbonsai_list="23,130,108,94"
        ;;

    "blue")
        ICON_COLOR="Adwaita-blue"
        THEME="Orchis-Teal-Dark"
        COLOR_C=blue
        COLOR_HEX="#458588"
        COLOR_M_HEX="#80aa9e"
        BG_COLOR_HEX="#0d3138"
        terminal_color="\033[38;5;109m"
        terminal_bg_color="\033[38;5;17m"
        cbonsai_list="17,130,109,94"
        ;;

    "purple")
        ICON_COLOR="Adwaita-purple"
        THEME="Orchis-Purple-Dark"
        COLOR_C=magenta
        COLOR_HEX="#b16286"
        COLOR_M_HEX="#d3869b"
        BG_COLOR_HEX="#3f2d35"
        terminal_color="\033[38;5;175m"
        terminal_bg_color="\033[38;5;54m"
        cbonsai_list="54,130,175,94"
        ;;

    "pink")
        ICON_COLOR="Adwaita-pink"
        THEME="Orchis-Pink-Dark"
        COLOR_C=magenta
        COLOR_HEX="#d3869b"
        COLOR_M_HEX="#f2b3c6"
        BG_COLOR_HEX="#3c2230"
        terminal_color="\033[38;5;211m"
        terminal_bg_color="\033[38;5;89m"
        cbonsai_list="89,130,211,94"
        ;;

    "brown")
        ICON_COLOR="Adwaita-brown"
        THEME="Orchis-Brown-Dark"
        COLOR_C=red
        COLOR_HEX="#a0522d"
        COLOR_M_HEX="#c9855e"
        BG_COLOR_HEX="#3a2318"
        terminal_color="\033[38;5;94m"
        terminal_bg_color="\033[38;5;52m"
        cbonsai_list="52,130,94,94"
        ;;

    *)
        ICON_COLOR="Adwaita-teal"
        THEME="Orchis-Teal-Dark"
        COLOR_C=cyan
        COLOR_HEX="#689d6a"
        COLOR_M_HEX="#8bba7f"
        BG_COLOR_HEX="#1e352d"
        terminal_color="\033[38;5;108m"
        terminal_bg_color="\033[38;5;23m"
        cbonsai_list="23,130,108,94"
        ;;
esac

gsettings set org.gnome.desktop.interface icon-theme $ICON_COLOR
gtk4-update-icon-cache

echo "{'terminal_color': '$terminal_color', 'terminal_bg_color': '$terminal_bg_color', 'cbonsai_list': '$cbonsai_list', 'colorc': '$COLOR_C'}" | gomplate -f $TEMPLATE_PATH/terminal-opening-colors.zsh.template -o ~/.config/zsh/.colors.zsh -d data=stdin:///foo.json

magick $2 -set option:size '%[fx:min(w,h)]x%[fx:min(w,h)]' xc:none +swap -gravity center -composite -resize 150x150 -bordercolor "$COLOR_HEX" -border 12%x12% $HOME/Pictures/wallpaper-square.png
magick $2 -set option:size '%[fx:min(w,h)]x%[fx:min(w,h)]' xc:none +swap -gravity center -composite -resize 150x150 $HOME/Pictures/wallpaper-square-nb.png
