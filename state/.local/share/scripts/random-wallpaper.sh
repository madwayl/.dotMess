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
WALLPAPER_DIR=$HOME/Pictures/Gruvbox-mix
TEMP_FILE=$HOME/Pictures/wallpapers.txt

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

	img=$(find "$WALLPAPER_DIR" -type f \( -iname '*.jpg' -o -iname '*.png' -o -iname '*.jpeg' -o -iname '*.gif' -o -iname '*.bmp' \) | shuf -n 1)

	while grep -Fxq "$img" "$TEMP_FILE"; do
		img=$(find "$WALLPAPER_DIR" -type f \( -iname '*.jpg' -o -iname '*.png' -o -iname '*.jpeg' -o -iname '*.gif' -o -iname '*.bmp' \) | shuf -n 1)
	done

	if [ "$(wc -l < "$TEMP_FILE")" -gt 10 ]; then
		sed -i '1d' $TEMP_FILE
	else
		echo $img >> $TEMP_FILE
	fi

	positions=('center' 'top' 'left' 'right' 'bottom' 'top-left' 'top-right' 'bottom-left' 'bottom-right')
	export SWWW_TRANSITION_POS=$(printf "%s\n" "${positions[@]}" | shuf -n 1)

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

	# find "$HOME/.dotMess/wallpapers" -type f \( -iname '*.jpg' -o -iname '*.png' -o -iname '*.jpeg' -o -iname '*.gif' -o -iname '*.bmp' \) |
	# while read -r img; do
	# 	[ -e "$img" ] || continue  # skip if no matching files
	# 	filename=$(basename "$img")
	# 	lutgen apply -n 0 -l 16 -s 256 -L 0.5 \
	# 	-o "$HOME/Pictures/Gruvbox-mix/$filename" \
	# 	-P "$img" \
	# 	-- 141617 181818 32302f 504945 992e28 992853 cc3c32 db4740 f2594b \
	# 	ef4d40 cc241d fb4934 995628 d65d0e cc6d32 f28534 ef8740 fe8019 997c28 \
	# 	cc9832 e9b143 efab40 d79921 fabd2f 789928 9ccc32 b0b846 a1fc33 98971a \
	# 	b8bb26 28994f 32cc76 8bba7f 689d6a 8ec07c 40ef85 32ccaf 289983 80aa9e \
	# 	458588 40efcc 83a598 cc3273 ef4085 d3869b b16286 7c6f64 928374 a89984 e2cca9 e3e1dc ebdbb2
	# done

	magick $img -modulate 80,145 $HOME/Pictures/wallpaper.png
	magick $img -modulate 80,145 -filter Gaussian -resize 20% -blur 0x3.5 $HOME/Pictures/wallpaper-blur.png
	magick $img -modulate 80,145 -set option:size '%[fx:min(w,h)]x%[fx:min(w,h)]' xc:none +swap -gravity center -composite -resize 150x150 -bordercolor "$SDDM_COLOR" -border 12%x12% $HOME/Pictures/wallpaper-square.png

	cp $HOME/Pictures/wallpaper.png /usr/share/sddm/themes/silent/backgrounds/default.png

	TEMPLATE_PATH="/home/madwayl/.dotMess/state/.local/share/templates/"

	# 8 NIRI KDL
	echo "{'sddm_color': '$SDDM_COLOR', 'sddm_bg_color': '$SDDM_BG_COLOR', 'theme': '$THEME', 'icon_color': '$ICON_COLOR'}" | gomplate -f $TEMPLATE_PATH/niri-env.kdl.template -o ~/.config/niri/theme.kdl -d data=stdin:///foo.json

	# GTK 4.0
	echo "{'theme': '$THEME', 'icon_color': '$ICON_COLOR'}" | gomplate -f $TEMPLATE_PATH/gtk-4.0-settings.ini.template -o ~/.config/gtk-4.0/settings.ini -d data=stdin:///foo.json
	# GTK 3.0
	echo "{'theme': '$THEME', 'icon_color': '$ICON_COLOR'}" | gomplate -f $TEMPLATE_PATH/gtk-3.0-settings.ini.template -o ~/.config/gtk-3.0/settings.ini -d data=stdin:///foo.json
	# GTK 2.0
	echo "{'theme': '$THEME', 'icon_color': '$ICON_COLOR'}" | gomplate -f $TEMPLATE_PATH/gtkrc.template -o ~/.config/gtk-2.0/gtkrc -d data=stdin:///foo.json
	# PROFILE
	echo "{'theme': '$THEME', 'icon_color': '$ICON_COLOR'}" | gomplate -f $TEMPLATE_PATH/profile.template -o ~/.profile -d data=stdin:///foo.json
	# XSETTINGSD
	echo "{'theme': '$THEME', 'icon_color': '$ICON_COLOR'}" | gomplate -f $TEMPLATE_PATH/xsettingsd.conf.template -o ~/.config/xsettingsd/xsettingsd.conf -d data=stdin:///foo.json

	# ln -sfn /usr/share/themes/$THEME/gtk-3.0/assets /home/madwayl/.config/gtk-3.0/
	# ln -sfn /usr/share/themes/$THEME/gtk-3.0/gtk.css /home/madwayl/.config/gtk-3.0/
	# ln -sfn /usr/share/themes/$THEME/gtk-3.0/gtk-dark.css /home/madwayl/.config/gtk-3.0/
	
	# ln -sfn /usr/share/themes/$THEME/gtk-4.0/assets /home/madwayl/.config/gtk-4.0/
	# ln -sfn /usr/share/themes/$THEME/gtk-4.0/gtk.css /home/madwayl/.config/gtk-4.0/
	# ln -sfn /usr/share/themes/$THEME/gtk-4.0/gtk-dark.css /home/madwayl/.config/gtk-4.0/

	gsettings set org.gnome.desktop.interface gtk-theme $THEME
	gsettings set org.gnome.desktop.interface icon-theme $ICON_COLOR

	gtk4-update-icon-cache

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
	echo "{'color': '$COLOR', 'bg_color': '$BG_COLOR'}" | gomplate -f $TEMPLATE_PATH/niri-switch.css.template -o ~/.config/niri-switch/style.css -d data=stdin:///foo.json

	killall niri-switch-daemon; $CARGO_HOME/bin/niri-switch-daemon &

	if [[ $1 == '--retrigger' ]]; then
		exit 1
	fi

done

# magick $wallpaper_choice -filter Gaussian -resize 20% -blur 2x20 /tmp/lockscreen.png