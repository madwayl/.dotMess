#!/usr/bin/env bash

# Get the current battery percentage
battery_percentage=$(cat /sys/class/power_supply/BAT1/capacity) # BAT1

# Get the battery status (Charging or Discharging)
battery_status=$(cat /sys/class/power_supply/BAT1/status) # BAT1

# Define the battery icons for each 10% segment
battery_icons=("󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰁹")

# Define the charging icon
charging_icon="󰂄"

# Calculate the index for the icon array
icon_index=$((battery_percentage / 10))

# Get the corresponding icon

# Check if the battery is charging
if [ "$battery_status" = "Charging" ]; then
	battery_icon="$charging_icon"
else
	battery_icon=${battery_icons[icon_index]}
fi

# Output the battery percentage and icon
echo "$battery_icon $battery_percentage%"