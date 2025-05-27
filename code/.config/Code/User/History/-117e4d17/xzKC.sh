#!/usr/bin/env bash

# Get the current battery percentage
battery_percentage=$(cat /sys/class/power_supply/BAT1/capacity) # BAT1

# Get the battery status (Charging or Discharging)
battery_status=$(cat /sys/class/power_supply/BAT1/status) # BAT1

# Define the battery icons for each 10% segment
battery_icons=("󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰁹")

# Define the charging icon
charging_icon=("󰢜" "󰢜" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅")


for capacity in /sys/class/power_supply/BAT*/capacity; do
    if [[ -f "$capacity" ]]; then
        total_capacity=$((total_capacity + $(<"$capacity")))
        battery_count=$((battery_count + 1))
    fi
done

# Exit if no battery is found
if ((battery_count == 0)); then
    exit 0
fi

# Determine the icon based on average capacity
average_capacity=$((total_capacity / battery_count))

# Calculate the index for the icon array
icon_index=$((average_capacity / 10))

# Get the corresponding icon

# Check if the battery is charging
if [ "$battery_status" = "Charging" ]; then
	battery_icon=${charging_icon[icon_index]}
else
	battery_icon=${battery_icons[icon_index]}
fi

# Output the battery percentage and icon

case "$1" in
	icon)
		echo "$battery_icon"
        ;;
    icon+percentage)
		echo "$battery_icon $average_capacity%"
        ;;
    percentage)
        echo -n "$average_capacity% "
        ;;
    int)
        echo -n "$average_capacity"
        ;;
    status)
        echo -n "$battery_status"
        ;;
    *)
        echo "Invalid format option: $1. Use 'icon', 'percentage', 'int', 'status', or 'status-icon'."
        exit 1
        ;;
esac