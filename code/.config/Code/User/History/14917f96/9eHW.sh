#!/usr/bin/env bash

display="$1"
operation=$2
value=$3

case $display in
"all")
    brightness_1=$(brightnessctl --device='intel_backlight' s ${operation}${value}% | awk '/Current brightness/ {gsub(/[(%)]/,"",$4); print $4}')
    #!/usr/bin/env bash

    monitors=$(ddcutil detect | awk '
        /I2C bus:/ {
            match($3, /i2c-([0-9]+)/, m)
            busnum = m[1]
        }
        /Model:/ {model = $2}
        /Serial number:/ {
            serial = $3
            printf "{ \"bus\": %s, \"model\": \"%s\", \"serial\": \"%s\" }\n", busnum, model, serial
        }' | jq -s .
    )

    jq -c '.[]' <<< $monitors | while read i; do
        # do stuff with $i
        serial=$(jq --raw-output '.serial' <<< "$i")
        [[ -z $serial ]] && continue

        model=$(jq --raw-output '.model' <<< "$i")
        bus=$(jq --raw-output '.bus' <<< "$i")

        ddcutil --sleep-multiplier=0.1 --skip-ddc-checks --bus=$bus setvcp 10 ${operation} ${value}
        brightness_2=$(ddcutil --sleep-multiplier=0.1 --skip-ddc-checks --bus=$bus getvcp 10 | grep -oP 'current value =\s*\K\d+')
        # do your stuff
    done
    ;;
"focused")
    focused_monitor = $(hyprctl -j monitors | jq '.[] | select(.focused==true) | .name')
    echo $focused_monitor
    if [[ $focused_monitor  == "eDP-1" ]]; then
        brightness=$(brightnessctl --device='intel_backlight' s ${operation}${value}% | awk '/Current brightness/ {gsub(/[(%)]/,"",$4); print $4}')
    else
        # Identify and retrieve the serial number of the display which has the focus.
        display_serial_num=$(hyprctl -j monitors | jq -r '.[] | select(.focused==true) | .serial')
        ddcutil --sleep-multiplier=0.1 --skip-ddc-checks --sn $display_serial_num setvcp 10 ${operation} ${value}
        # get brightness value
        brightness=$(ddcutil --sleep-multiplier=0.1 --skip-ddc-checks --sn $display_serial_num getvcp 10 | grep -oP 'current value =\s*\K\d+')
    fi
    ;;
*)
    echo "wrong usage\Value Passed : $@" ;;
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