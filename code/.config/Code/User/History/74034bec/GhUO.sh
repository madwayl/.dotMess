#!/usr/bin/env bash

## Author  : Aditya Shakya (adi1090x)
## Github  : @adi1090x
#
## Applets : Screenshot

# Import Current Theme
type="$HOME/.config/rofi/screenshot/"
style='screenshot.rasi'
theme="$type/$style"

# Theme Elements
prompt='Screenshot'
mesg="DIR: `xdg-user-dir PICTURES`/Screenshots"

# if [[ "$theme" == *'type-1'* ]]; then
	# list_col='1'
	# list_row='5'
	# win_width='400px'
# elif [[ "$theme" == *'type-3'* ]]; then
	list_col='6'
	list_row='1'
	win_width='120px'
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
	option_1="  Capture Desktop"
	option_2="  Capture Area"
	if [[ ! -e '/tmp/cast' ]]; then
		option_3="  Screencast Desktop"
	else
		option_3="  Stop Recording"
	fi
	if [[ ! -e '/tmp/castarea' ]]; then
		option_4="  Screencast Area"
	else
		option_3="  Stop Recording"
	fi
	option_5="  Screencast Window"
else
	option_1="  "
	option_2="  "
	if [[ ! -e '/tmp/cast' ]]; then
		option_3="  "
	else
		option_3="  "
	fi
	if [[ ! -e '/tmp/castarea' ]]; then
		option_4="  "
	else
		option_3="  "
	fi
	option_5="  "
fi

# Rofi CMD
rofi_cmd() {
	a=""
	if [[ -e '/tmp/cast' ]]; then
		a="${a},2"
	fi
	if [[ -e '/tmp/castarea' ]]; then
		a="${a},3"
	fi
	rofi \
		# -theme-str "window {width: $win_width;}" \
		# -theme-str "listview {columns: $list_col; lines: $list_row;}" \
		-theme-str 'textbox-prompt-colon {str: "";}' \
		-dmenu \
		-p "$prompt" \
		-mesg "$mesg" \
		-markup-rows \
		-theme ${theme} \
		-a ${a}
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5" | rofi_cmd
}

# Screenshot
time=`date +%Y-%m-%d-%H-%M-%S`
geometry=`xrandr | grep 'current' | head -n1 | cut -d',' -f2 | tr -d '[:blank:],current'`
dir="$(xdg-user-dir PICTURES)/Screenshots"
file="Screenshot_${time}_${geometry}.png"

if [[ ! -d "$dir" ]]; then
	mkdir -p "$dir"
fi

# notify and view screenshot
notify_view() {
	notify_cmd_shot='notify-send -u low --wait --expire-time=5000'
	action=$(${notify_cmd_shot} --app-name=screenshot --action=edit --action=remove "Copied to clipboard.")
	# ksnip ${dir}/"$file"
	case $action in
        0)
			ksnip ${dir}/"$file"
			;;
        1)
            rm ${dir}/"$file"
			${notify_cmd_shot} "Screenshot Deleted." 
			;;
    esac
	# if [[ -e "$dir/$file" ]]; then
	# 	${notify_cmd_shot} "Screenshot Saved."
	# else
	# 	${notify_cmd_shot} "Screenshot Deleted."
	# fi
}

# countdown
countdown () {
	for sec in `seq $1 -1 1`; do
		dunstify -t 1000 --replace=699 "Taking shot in : $sec"
		sleep 1
	done
}

# 1
shotnow () {
	wl-copy < $(grimblast save output ${dir}/${file})
	notify_view
}

shot5 () {
	countdown '5'
	sleep 1 && cd ${dir} && maim -u -f png | copy_shot
	notify_view
}

shot10 () {
	countdown '10'
	sleep 1 && cd ${dir} && maim -u -f png | copy_shot
	notify_view
}

# 2
shotwin () {
	wl-copy < $(grimblast save area ${dir}/${file})
	notify_view
}

# 3
cast() {
	if [[ ! -e '/tmp/cast' ]]; then
		file="Screenshot_${time}.mp4"
		output=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused == true) | .name')
		wl-screenrec --file=${dir}/${file} --output=$output &
		echo "$!" > '/tmp/cast'
	else
		kill $(cat /tmp/cast)
		rm /tmp/cast
	fi
}

# 4
castarea() {
	if [[ ! -e '/tmp/castarea' ]]; then
		file="Screenshot_${time}.mp4"
		wl-screenrec -g "$(slurp)" --file=${dir}/${file} &
		echo "$!" > '/tmp/castarea'
	else
		kill $(cat /tmp/castarea)
		rm /tmp/castarea
	fi
}

# 5
shotall() {
	wl-copy < $(grimblast save screen ${dir}/${file})
	notify_view
}

# Execute Command
run_cmd() {
	if [[ "$1" == '--opt1' ]]; then
		shotnow
	elif [[ "$1" == '--opt2' ]]; then
		shotwin
	elif [[ "$1" == '--opt3' ]]; then
		cast
	elif [[ "$1" == '--opt4' ]]; then
		castarea
	elif [[ "$1" == '--opt5' ]]; then
		shotall
	fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $option_1)
		run_cmd --opt1
        ;;
    $option_2)
		run_cmd --opt2
        ;;
    $option_3)
		run_cmd --opt3
        ;;
    $option_4)
		run_cmd --opt4
        ;;
    $option_5)
		run_cmd --opt5
        ;;
esac


