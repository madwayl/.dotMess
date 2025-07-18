#!/usr/bin/env bash

## Author  : Aditya Shakya (adi1090x)
## Github  : @adi1090x
#
## Applets : Screenshot

# Import Current Theme
type="$HOME/.config/rofi/screenproject/"
style='screenproject.rasi'
theme="$type/$style"

# Theme Elements
prompt='Screen Profile'
profile=$(cat /tmp/monitor_profile)
mesg="Current Monitor Profile :: $profile"

# if [[ "$theme" == *'type-1'* ]]; then
	# list_col='1'
	# list_row='5'
	# win_width='400px'
# elif [[ "$theme" == *'type-3'* ]]; then
list_col='1'
list_row='3'
win_width='422px'
# elif [[ "$theme" == *'type-5'* ]]; then
# 	list_col='1'
# 	list_row='5'
# 	win_width='520px'
# elif [[ ( "$theme" == *'type-2'* ) || ( "$theme" == *'type-4'* ) ]]; then
# 	list_col='5'
# 	list_row='1'
# 	win_width='670px'
# fi

# Options
layout=`cat ${theme} | grep 'USE_ICON' | cut -d'=' -f2`
if [[ "$layout" == 'NO' ]]; then
	option_1="󰷛 Default Off"
	option_2="󰍺 Default Room"
	option_3="󱒃 Mirror Screen"
else
	option_1="  󰷛  "
	option_2="  󰍺  "
	option_3="  󱒃  "
fi

# Rofi CMD
rofi_cmd() {
	case "$profile" in
		'default-off') a=0 ;;
		'default-room') a=1 ;;
		'mirror') a=2 ;;
		*) a=0;;
	esac
	rofi -theme-str "window {width: $win_width;}" \
		-theme-str "listview {columns: $list_col; lines: $list_row;}" \
		-theme-str 'textbox-prompt-colon {str: "󰍹";}' \
		-dmenu \
		-p "$mesg" \
		-mesg "$mesg" \
		-markup-rows \
		-theme ${theme} \
		-a ${a}
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$option_1\n$option_2\n$option_3" | rofi_cmd
}

# notify
# notify_view() {
# 	notify_cmd_shot='notify-send -u low --wait --expire-time=5000'
# 	action=$(${notify_cmd_shot} --app-name=screenshot --action=Edit --action=Remove "Screenshot" "Copied to clipboard" -i ${dir}/${file})
# 	# ksnip ${dir}/"$file"
# 	case $action in
# 		0)
# 			ksnip ${dir}/"$file"
# 			;;
# 		1)
# 			rm ${dir}/"$file"
# 			${notify_cmd_shot} "Screenshot Deleted." 
# 			;;
# 		*)
# 			exit
# 			;;
# 	esac
# 	# if [[ -e "$dir/$file" ]]; then
# 	# 	${notify_cmd_shot} "Screenshot Saved."
# 	# else
# 	# 	${notify_cmd_shot} "Screenshot Deleted."
# 	# fi
# }

# # https://superuser.com/a/1593924 - for creating and closing notification using GIO GdBus
# /usr/bin/gdbus call --session \
#     --dest org.freedesktop.Notifications \
#     --object-path /org/freedesktop/Notifications \
#     --method org.freedesktop.Notifications.Notify \
#     shikane \
#     0 \
#     gtk-dialog-info \
#     "Shikane" \
#     "Switched to $next_profile" \
#     [] \
#     "{'urgency':<byte 1>}" \
#     1500

# 1 & 2
switch() {
	/usr/bin/shikanectl switch $1
}

# 3
mirror() {
	/usr/bin/wl-mirror -S --fullscreen-output DP-1 --fullscreen eDP-1
}

# Execute Command
run_cmd() {
	if [[ "$1" == 'default-off' || "$1" == 'default-room' ]]; then
		echo $1 > /tmp/monitor_profile
		if [ "$profile" == "mirror" ]; then
			pkill -f "/usr/bin/wl-mirror -S --fullscreen-output DP-1 --fullscreen eDP-1"
			rm -f /run/user/1000/pipectl.1000.wl-present.pipe
		fi
		switch $1
	elif [[ "$1" == 'mirror' ]]; then
		echo $1 > /tmp/monitor_profile
		mirror
		exit 1
	fi

	
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
	$option_1)
		run_cmd 'default-off'
		;;
	$option_2)
		run_cmd 'default-room'
		;;
	$option_3)
		run_cmd 'mirror'
		;;
esac

