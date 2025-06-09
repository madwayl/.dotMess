#!/usr/bin/env bash

display="$1"
operation=$2
value=$3
bus=$4

savePath() {
    [[ ! -x $XDG_RUNTIME_DIR/brightness/ ]] && mkdir $XDG_RUNTIME_DIR/brightness/
    for bus in $(ddcutil detect | grep -E 'Serial number:\s{8}.+' -B6 | grep -oP '(?<=i2c-)[0-9]+'); do
        brightness=$(ddcutil --sleep-multiplier=0.01 --skip-ddc-checks --bus=$bus getvcp 10 | grep -oP 'current value =\s*\K\d+')
        echo $brightness > $XDG_RUNTIME_DIR/brightness/${bus}
    done
}

use_brightnessctl() {
    echo $(brightnessctl --device='intel_backlight' s ${value}%${operation} | awk '/Current brightness/ {gsub(/[(%)]/,"",$4); print $4}')
}

use_ddcutil() {
    ddcutil --sleep-multiplier=0.001 --skip-ddc-checks --bus=$bus setvcp 10 ${operation} ${value}
    brightness=$(ddcutil --sleep-multiplier=0.01 --skip-ddc-checks --bus=$bus getvcp 10 | grep -oP 'current value =\s*\K\d+')
    echo $brightness > $XDG_RUNTIME_DIR/brightness/${bus}
    pkill -RTMIN+2 waybar
}

case $display in
"all")
    use_brightnessctl "$value" "$operation"
    for bus in $(ddcutil detect | grep -E 'Serial number:\s{8}.+' -B6 | grep -oP '(?<=i2c-)[0-9]+'); do
        use_ddcutil "$value" "$operation" "$bus"
    done
    ;;
"focused")
    focused_monitor=$(hyprctl -j monitors | jq --raw-output '.[] | select(.focused==true) | .name')
    if [[ ! "$focused_monitor"  == "eDP-1" ]]; then
        # Identify and retrieve the serial number of the display which has the focus.
        if [[ ! -n $bus ]]; then
            bus=$(ddcutil detect 2>/dev/null | grep -B5 "card[0-9]*-${focused_monitor}$" | grep -oP '(?<=i2c-)[0-9]+')
        fi
        use_ddcutil "$value" "$operation" "$bus"
    else
        brightness=$(brightnessctl --device='intel_backlight' s ${value}%${operation} | awk '/Current brightness/ {gsub(/[(%)]/,"",$4); print $4}')
    fi
    ;;
"init")
    savePath
    ;;
*)
    echo "wrong usage\Value Passed : $@" 
    ;;
esac

# Then we change its brightness level.
# ddcutil --sn "$display_serial_num" setvcp 10 $@


# makoctl dismiss -g app-name="ddc-brightness"
# Notification Sender
# notify-send \
#     --app-name="ddc-brightness" \
#     --urgency=low \
#     --expire-time=1000 \
#     --hint int:value:$brightness \
#     "Brightness" \
#     "Display: $focused_monitor Level: $brightness"