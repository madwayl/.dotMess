#!/usr/bin/env bash

# Define the path to your Shikane config directory
PROFILE_FILE="$HOME/.config/shikane/.current_profile"

# Set the default profile if it doesn't exist
if [ ! -f "$PROFILE_FILE" ]; then
    echo "default-room" > "$PROFILE_FILE"
fi

# Read the current profile from the file
file="$(cat "$PROFILE_FILE")"
IFS=":" read -r current_profile <<< "$file"

# Not required using history=0 for mako
# /usr/bin/gdbus call --session \
#             --dest org.freedesktop.Notifications \
#             --object-path /org/freedesktop/Notifications \
#             --method org.freedesktop.Notifications.CloseNotification \
#             "$id"

# /usr/bin/makoctl dismiss -n "$id"

# Define all available profiles
profiles=("default-off" "default-room" "mirror")  # Add your actual profile names here

# Find the next profile in the list
next_profile="default-room"  # Default to the first profile if no match
for i in "${!profiles[@]}"; do
    if [ "${profiles[$i]}" == "$current_profile" ]; then
        next_profile=${profiles[$(( (i + 1) % ${#profiles[@]} ))]}
        break
    fi
done

makoctl dismiss -g app-name="shikane"

# https://superuser.com/a/1593924 - for creating and closing notification using GIO GdBus
/usr/bin/gdbus call --session \
    --dest org.freedesktop.Notifications \
    --object-path /org/freedesktop/Notifications \
    --method org.freedesktop.Notifications.Notify \
    shikane \
    0 \
    gtk-dialog-info \
    "Shikane" \
    "Switched to $next_profile" \
    [] \
    "{'urgency':<byte 1>}" \
    1500

# Save the next profile to the file
echo "$next_profile" > "$PROFILE_FILE"

# Use Swaymsg to switch the profile (Swaymsg switches outputs, Shikane will handle the actual profile switch)
case "$next_profile" in
    default-off|default-room)
        if [ "$current_profile" == "mirror" ]; then
            pkill -f "/usr/bin/wl-mirror -S --fullscreen-output DP-1 --fullscreen eDP-1"
            rm -f /run/user/1000/pipectl.1000.wl-present.pipe
        fi
        $HOME/.bin/shikanectl switch $next_profile
        ;;
    mirror)
        /usr/bin/wl-mirror -S --fullscreen-output DP-1 --fullscreen eDP-1
        ;;
    *)
        exit 1
        ;;
esac
