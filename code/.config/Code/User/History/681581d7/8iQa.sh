#!/usr/bin/env bash

# enable float
WinFloat=$(hyprctl -j clients | jq '.[] | select(.focusHistoryID == 0) | .floating')
WinPinned=$(hyprctl -j clients | jq '.[] | select(.focusHistoryID == 0) | .pinned')

if [ "${WinFloat}" == "false" ] && [ "${WinPinned}" == "false" ] ; then
    hyprctl dispatch togglefloating active
fi

# toggle pin
hyprctl dispatch pin active
