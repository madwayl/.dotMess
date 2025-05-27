#!/usr/bin/env bash

# Get the current battery percentage
battery_percentage=$(cat /sys/class/power_supply/BAT1/capacity) # BAT1

# Get the battery status (Charging or Discharging)
battery_status=$(cat /sys/class/power_supply/BAT1/status) # BAT1

# Define the battery icons for each 10% segment
battery_icons=("󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰁹")

# Define the charging icon
charging_icon=("󰢜" "󰢜" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅")

# Calculate the index for the icon array
icon_index=$((battery_percentage / 10))

# Get the corresponding icon

# Check if the battery is charging
if [ "$battery_status" = "Charging" ]; then
	battery_icon=${charging_icon[icon_index]}
else
	battery_icon=${battery_icons[icon_index]}
fi

# Output the battery percentage and icon
echo "$battery_icon $battery_percentage%"

case "$1" in
    icon+percentage)
        if [[ "$battery_status" == "Charging" ]]; then
            echo -n "${charging_icons[$index]} "
        else
            echo -n "${discharging_icons[$index]} "
        fi
        ;;
    percentage)
        echo -n "$battery_percentage% "
        ;;
    int)
        echo -n "$average_capacity "
        ;;
    status)
        echo -n "$battery_status "
        ;;
    status-icon)
        case "$battery_status" in
        "Charging")
            echo -n "${status_icons[0]} "
            ;;
        "Not Charging")
            echo -n "${status_icons[1]} "
            ;;
        *)
            echo -n "${status_icons[2]} "
            ;;
        esac
        ;;
    *)
        echo "Invalid format option: $1. Use 'icon', 'percentage', 'int', 'status', or 'status-icon'."
        exit 1
        ;;
esac