#!/usr/bin/env bash

handle_windowtitlev2 () {
    # Description: emitted when a window title changes.
    # Format: `WINDOWADDRESS,WINDOWTITLE`
    windowaddress=${1%,*}
    windowtitle=${1#*,}

    case $windowtitle in
        *"(Bitwarden"*"Password Manager) - Bitwarden"* | "Sign in - Google accounts"*)
        hyprctl --batch \
            "dispatch togglefloating address:0x$windowaddress;"\
            "dispatch resizewindowpixel exact 480 650, address:0x$windowaddress;"\
            "dispatch centerwindow"
            # "dispatch movecursortocorner, 1, address:0x$windowaddress;"\
        ;;
    #   specificwindowtitle) commands;;
    esac
}

handle_newmonitor() {
    $HOME/.config/hypr/scripts/random-wallpaper.sh $HOME/.dotMess/wallpapers
    ags quit && ags run
    $XDG_CONFIG_HOME/hypr/scripts/brightness-control.sh init &
}

handle() {
    # $1 Format: `EVENT>>DATA`
    # example: `workspace>>2`

    event=${1%>>*}
    data=${1#*>>}

    case $event in
        windowtitlev2) handle_windowtitlev2 "$data";;
        monitoradded) handle_newmonitor
    #   anyotherevent) handle_otherevent "$data";;
        # *) echo "unhandled event: $event" ;;
    esac
}

# Listen to the Hyprland socket for events and process each line with the handle function
socat -U - UNIX-CONNECT:"$XDG_RUNTIME_DIR"/hypr/"$HYPRLAND_INSTANCE_SIGNATURE"/.socket2.sock | while read -r line; do handle "$line"; done