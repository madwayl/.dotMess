#!/usr/bin/env bash

pw-dump | jq -e '
    any(
        .[]; 
        .info.props["node.name"] == "xdg-desktop-portal-wlr" and 
        .info.props["stream.is-live"] == true
    )
' > /dev/null
