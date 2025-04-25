#!/usr/bin/env bash

# Define the path to your Shikane config directory
PROFILE_FILE="$HOME/.config/shikane/.current_profile"

# Set the default profile if it doesn't exist
if [ ! -f "$PROFILE_FILE" ]; then
    echo "default" > "$PROFILE_FILE"
fi

# Read the current profile from the file
file="$(cat "$PROFILE_FILE")"
IFS=":" read -r current_profile id <<< "$file"

# Not required using history=0 for mako
# /usr/bin/gdbus call --session \
#             --dest org.freedesktop.Notifications \
#             --object-path /org/freedesktop/Notifications \
#             --method org.freedesktop.Notifications.CloseNotification \
#             "$id"

# /usr/bin/makoctl dismiss -n "$id"

# Define all available profiles
profiles=("default-off" "default-room" "default")  # Add your actual profile names here

# Find the next profile in the list
next_profile="default"  # Default to the first profile if no match
for i in "${!profiles[@]}"; do
    if [ "${profiles[$i]}" == "$current_profile" ]; then
        next_profile=${profiles[$(( (i + 1) % ${#profiles[@]} ))]}
        break
    fi
done

# Use Swaymsg to switch the profile (Swaymsg switches outputs, Shikane will handle the actual profile switch)
/opt/shikane/shikanectl switch $next_profile

makoctl dismiss -g app-name="shikane"

# https://superuser.com/a/1593924 - for creating and closing notification using GIO GdBus
id="$(/usr/bin/gdbus call --session \
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
    )"

# Save the next profile to the file
echo "$next_profile:$id" > "$PROFILE_FILE"
