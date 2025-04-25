#!/usr/bin/env bash

# Modify the brightness level of the display which has
# the focus.
#
# Usage: ./ddc-brightness [+-] <level>
# Examples:
#  ./ddc-brightness + 10 # increase brightness level by 10
#  ./ddc-brightness   30 # set brightness level to 30

# First we identify and retrieve the serial number of
# the display which has the focus.
display_serial_num=$(
    swaymsg -t get_outputs |
    jq '.[] | select(.focused) | .serial' --raw-output)

# Then we change its brightness level.
# ddcutil --sn "$display_serial_num" setvcp 10 $@
ddcutil --bus=11 setvcp 10 $@

brightness=$(ddcutil --bus=11 getvcp 10 | grep -oP 'current value =\s*\K\d+')

makoctl dismiss -g app-name="ddc-brightness"
# Notification Sender
notify-send \
    --app-name="ddc-brightness" \
    --urgency=low \
    --expire-time=1000 \
    --hint int:value:$brightness \
    "Brightness" \
    "Display: $display_serial_num Level: $brightness"