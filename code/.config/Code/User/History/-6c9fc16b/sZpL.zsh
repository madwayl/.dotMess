
        alias c='clear' \
            in='${PM_COMMAND[@]} install' \
            un='${PM_COMMAND[@]} remove' \
            up='${PM_COMMAND[@]} upgrade' \
            pl='${PM_COMMAND[@]} search installed' \
            pa='${PM_COMMAND[@]} search all' \
            vc='code' \
            fastfetch='fastfetch --logo-type kitty' \
            ..='cd ..' \
            ...='cd ../..' \
            .3='cd ../../..' \
            .4='cd ../../../..' \
            .5='cd ../../../../..' \
            mkdir='mkdir -p' \
            ffec='_fuzzy_edit_search_file_content' \
            ffcd='_fuzzy_change_directory' \
            ffe='_fuzzy_edit_search_file'
