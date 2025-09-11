#!/bin/bash

MODE_FILE="$XDG_RUNTIME_DIR/hyprscroller/mode"

savePath() {
    [[ ! -d $XDG_RUNTIME_DIR/hyprscroller/ ]] && mkdir $XDG_RUNTIME_DIR/hyprscroller/
    echo $1 > $XDG_RUNTIME_DIR/hyprscroller/mode
    pkill -RTMIN+8 waybar
}

readCurrentMode() {
    # workspace=$(hyprctl activeworkspace -j | jq '.id')
    # current_mode=$(cat "$MODE_FILE"/$workspace)
    current_mode=$(cat "$MODE_FILE")
    if [[ "$current_mode" == "row" ]]; then
        icon="row"
        percent=0
        class="mode-row"
    elif [[ "$current_mode" == "col" ]]; then
        icon="column"
        percent=100
        class="mode-column"
    else
        icon="row"
        percent=0
        class=""
    fi

    echo "{\"icon\":\"$icon\", \"tooltip\":\"Scroller Mode: $current_mode\", \"class\":\"$class\",\"percentage\": $percent}"
}

writeMode() {
    current_mode=$(cat "$MODE_FILE")
    if [[ "$current_mode" == "row" ]]; then
        hyprctl dispatch scroller:setmode col
        savePath "col"
    elif [[ "$current_mode" == "col" ]]; then
        hyprctl dispatch scroller:setmode row
        savePath "row"
    else
        hyprctl dispatch scroller:setmode row
        savePath "row"
    fi
}

case $1 in
    "init")
        savePath "row";;
    "read")
        readCurrentMode;;
    "implement")
        writeMode;;
esac
