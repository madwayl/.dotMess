#!/usr/bin/env bash

# This script will randomly go through the files of a directory, setting it
# up as the wallpaper at regular intervals
#
# NOTE: this script uses bash (not POSIX shell) for the RANDOM variable

# Edit below to control the images transition
export WAYLAND_DISPLAY=wayland-1
export SWWW_TRANSITION_STEP=255

# This controls (in seconds) when to switch to the next image
INTERVAL=6800
WALLPAPER=$HOME/.dotMess/wallpapers

swww img --namespace bg $HOME/Pictures/wallpaper.png
swww img --namespace bg_overview $HOME/Pictures/wallpaper-blur.png

export SWWW_TRANSITION_FPS=60
export SWWW_TRANSITION_STEP=70
export SWWW_TRANSITION='outer'

if [[ $1 == '--retrigger' ]]; then
	echo "Re-Triggering Wallpaper Change"
elif pgrep -f "bash.*$(basename "$0")" | grep -v $$ > /dev/null; then
	echo "Bash session already running — exiting."
	exit 1
fi

while true; do

	if [[ $1 != '--retrigger' ]]; then
		sleep $INTERVAL
	fi

	img=$(find "$WALLPAPER" -type f \( -iname '*.jpg' -o -iname '*.png' -o -iname '*.jpeg' -o -iname '*.gif' -o -iname '*.bmp' \) | shuf -n 1)

	positions=('center' 'top' 'left' 'right' 'bottom' 'top-left' 'top-right' 'bottom-left' 'bottom-right')
	export SWWW_TRANSITION_POS=$(printf "%s\n" "${positions[@]}" | shuf -n 1)

	lutgen apply -n 16 -l 16 -s 256 -o $HOME/Pictures/wallpaper-lut.png -P $img -- 181818 cc241d 98971a d79921 458588 b16286 689d6a a89984 d65d0e ebdbb2 928374 fb4934 b8bb26 fabd2f 83a598 d3869b 8ec07c 504945 fe8019 141617 1d2021 282828 3c3836 32302f 3c1f1e 442e2d 4a2e1a 44372a 3f3518 473c29 32361a 333e34 1e352d 2d3f35 0d3138 2e3b3b 3f2d35 463640 4a4640 53504a e2cca9 f2594b f28534 e9b143 b0b846 8bba7f 80aa9e d3869b db4740 e3e1dc 7c6f64 a7c000 65c26b 4eb9ac d34295 ef4d40 ef8740 efab40 a1fc33 40ef85 40efcc ef4085 cc3c32 cc6d32 cc9832 9ccc32 32cc76 32ccaf cc3273 992e28 995628 997c28 789928 28994f 289983 992853

	magick $HOME/Pictures/wallpaper-lut.png -modulate 85,145 $HOME/Pictures/wallpaper.png
	magick $HOME/Pictures/wallpaper-lut.png -modulate 85,145 -filter Gaussian -resize 20% -blur 0x3.5 $HOME/Pictures/wallpaper-blur.png

	cp $HOME/Pictures/wallpaper.png /usr/share/sddm/themes/silent/backgrounds/default.png

	filename=$(basename "$img")
	BG_COLOR=$(jq --arg f "$filename" -r '.[$f]' $XDG_DATA_HOME/themes/image-themes.json)
	# BG_COLOR=$(echo "$filename" | cut -d"=" -f2 | cut -d"." -f1)
	COLOR=$(echo $BG_COLOR | cut -d"-" -f3)

	# echo "$BG_COLOR, $COLOR, $filename"

	case $COLOR in
		"red")
			ICON_COLOR="Adwaita-red"
			THEME="Orchis-Red-Dark"
			SDDM_COLOR="#cc241d"
			SDDM_BG_COLOR="#3c1f1e"
			terminal_color="\033[38;5;167m"     # #ea6962  red
			terminal_bg_color="\033[38;5;52m"
			cbonsai_list="52,130,124,94"      # Red
			;;
		"gray")
			ICON_COLOR="Adwaita-slate"
			THEME="Orchis-Grey-Dark"
			SDDM_COLOR="#a89984"
			SDDM_BG_COLOR="#4a4640"
			terminal_color="\033[38;5;245m"    # #928374  gray
			terminal_bg_color="\033[38;5;239m"
			cbonsai_list="237,130,245,94"     # Gray
			;;
		"orange")
			ICON_COLOR="Adwaita-orange"
			THEME="Orchis-Orange-Dark"
			SDDM_COLOR="#f28534"
			SDDM_BG_COLOR="#4a2e1a"
			terminal_color="\033[38;5;208m"    # #e78a4e
			terminal_bg_color="\033[38;5;94m"
			cbonsai_list="166,130,208,94"     # Orange
			;;
		"yellow")
			ICON_COLOR="Adwaita-yellow"
			THEME="Orchis-Yellow-Dark"
			SDDM_COLOR="#d79921"
			SDDM_BG_COLOR="#3f3518"
			terminal_color="\033[38;5;214m"  # #d8a657  yellow
			terminal_bg_color="\033[38;5;136m"
			cbonsai_list="136,130,229,94"     # Yellow
			;;
		"green")
			ICON_COLOR="Adwaita-green"
			THEME="Orchis-Green-Dark"
			SDDM_COLOR="#98971a"
			SDDM_BG_COLOR="#32361a"
			terminal_color="\033[38;5;142m"   # #a9b665  green
			terminal_bg_color="\033[38;5;22m"
			cbonsai_list="22,130,142,94"      # Green
			;;
		"aqua")
			ICON_COLOR="Adwaita-teal"
			THEME="Orchis-Teal-Dark"
			SDDM_COLOR="#689d6a"
			SDDM_BG_COLOR="#1e352d"
			terminal_color="\033[38;5;108m"    # #89b482  aqua
			terminal_bg_color="\033[38;5;23m"
			cbonsai_list="23,130,108,94"      # Aqua
			;;
		"blue")
			ICON_COLOR="Adwaita-blue"
			THEME="Orchis-Teal-Dark"
			SDDM_COLOR="#458588"
			SDDM_BG_COLOR="#0d3138"
			terminal_color="\033[38;5;109m"    # #7daea3  blue
			terminal_bg_color="\033[38;5;17m"
			cbonsai_list="17,130,109,94"      # Blue
			;;
		"purple")
			ICON_COLOR="Adwaita-purple"
			THEME="Orchis-Purple-Dark"
			SDDM_COLOR="#b16286"
			SDDM_BG_COLOR="#3f2d35"
			terminal_color="\033[38;5;175m"  # #d3869b  purple
			terminal_bg_color="\033[38;5;54m"
			cbonsai_list="54,130,175,94"      # Purple
			;;
		*)
			ICON_COLOR="Adwaita-teal"
			THEME="Orchis-Teal-Dark"
			SDDM_COLOR="#458588"
			SDDM_BG_COLOR="#1e352d"
			terminal_color="\033[38;5;108m"    # #89b482  aqua
			terminal_bg_color="\033[38;5;23m"
			cbonsai_list="23,130,108,94"      # Aqua
			;;
	esac

	TEMPLATE_PATH="/home/madwayl/.dotMess/state/.local/share/templates/"

	# 8 NIRI KDL
	echo "{'theme': '$THEME', 'icon_color': '$ICON_COLOR'}" | gomplate -f $TEMPLATE_PATH/niri-config.kdl.template -o ~/.config/niri/config.kdl -d data=stdin:///foo.json

	# GTK 4.0
	echo "{'theme': '$THEME', 'icon_color': '$ICON_COLOR'}" | gomplate -f $TEMPLATE_PATH/gtk-4.0-settings.ini.template -o ~/.config/gtk-4.0/settings.ini -d data=stdin:///foo.json
	# GTK 3.0
	echo "{'theme': '$THEME', 'icon_color': '$ICON_COLOR'}" | gomplate -f $TEMPLATE_PATH/gtk-3.0-settings.ini.template -o ~/.config/gtk-3.0/settings.ini -d data=stdin:///foo.json
	# GTK 2.0
	echo "{'theme': '$THEME', 'icon_color': '$ICON_COLOR'}" | gomplate -f $TEMPLATE_PATH/gtkrc.template -o ~/.config/gtk-2.0/gtkrc -d data=stdin:///foo.json
	# Profile
	echo "{'theme': '$THEME', 'icon_color': '$ICON_COLOR'}" | gomplate -f $TEMPLATE_PATH/profile.template -o ~/.profile -d data=stdin:///foo.json

	gsettings set org.gnome.desktop.interface gtk-theme $THEME
	gsettings set org.gnome.desktop.interface icon-theme $ICON_COLOR

	# 1 HYPRLOCK
	echo "{'color': '$COLOR'}" | gomplate -f $TEMPLATE_PATH/hyprlock.conf.template -o ~/.config/hypr/hyprlock.conf -d data=stdin:///foo.json

	# 2 WAYBAR
	echo "{'color': '$COLOR', 'bg_color': '$BG_COLOR'}" | gomplate -f $TEMPLATE_PATH/waybar-style.css.template -o ~/.config/waybar/style.css -d data=stdin:///foo.json

	# 3 SWAYNC
	echo "{'color': '$COLOR', 'bg_color': '$BG_COLOR'}" | gomplate -f $TEMPLATE_PATH/swaync-style.css.template -o ~/.config/swaync/addon.style.css -d data=stdin:///foo.json

	swww img --namespace bg $HOME/Pictures/wallpaper.png
	swww img --namespace bg_overview $HOME/Pictures/wallpaper-blur.png

	swaync-client -rs

	# 9 WezTerm
	echo "{'color': '$COLOR', 'bg_color': '$BG_COLOR'}" | gomplate -f $TEMPLATE_PATH/addon-colors.lua.template -o ~/.config/wezterm/themes/addon-colors.lua -d data=stdin:///foo.json

	# 9.2 Terminal Intro
	echo "{'terminal_color': '$terminal_color', 'terminal_bg_color': '$terminal_bg_color', 'cbonsai_list': '$cbonsai_list'}" | gomplate -f $TEMPLATE_PATH/terminal-opening-colors.zsh.template -o ~/.config/zsh/.colors.zsh -d data=stdin:///foo.json

	# 4 SDDM
	# echo "{'sddm_color': '$SDDM_COLOR', 'sddm_bg_color': '$SDDM_BG_COLOR'}" | gomplate -f $TEMPLATE_PATH/purple_leaves.conf.template -o /usr/share/sddm/themes/sddm-astronaut-theme/Themes/purple_leaves.conf -d data=stdin:///foo.json

	# 4 SDDM
	echo "{'sddm_color': '$SDDM_COLOR', 'sddm_bg_color': '$SDDM_BG_COLOR'}" | gomplate -f $TEMPLATE_PATH/silent-default.conf.template -o /usr/share/sddm/themes/silent/configs/default.conf -d data=stdin:///foo.json

	# 5 ROFI
	echo "{'color': '$COLOR', 'bg_color': '$BG_COLOR'}" | gomplate -f $TEMPLATE_PATH/rofi-theme-color.rasi.template -o ~/.config/rofi/shared/colors.rasi -d data=stdin:///foo.json

	# 6 AGS
	echo "{'color': '$COLOR', 'bg_color': '$BG_COLOR'}" | gomplate -f $TEMPLATE_PATH/osd-colors.scss.template -o ~/.config/ags/widgets/osd/osd-colors.scss -d data=stdin:///foo.json

	# 7 niri-switch
	echo "{'bg_color': '$BG_COLOR'}" | gomplate -f $TEMPLATE_PATH/niri-switch.css.template -o ~/.config/niri-switch/style.css -d data=stdin:///foo.json

	killall niri-switch-daemon; $CARGO_HOME/bin/niri-switch-daemon &

	if [[ $1 == '--retrigger' ]]; then
		exit 1
	fi

done

# magick $wallpaper_choice -filter Gaussian -resize 20% -blur 2x20 /tmp/lockscreen.png