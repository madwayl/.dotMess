# All zsh-fzf- tab

# Colors

export FZF_DEFAULT_OPTS='
--color=fg:#e2cca9,hl:#a89984,fg+:#e2cca9,bg+:#32302f,hl+:#e2cca9,info:#83a598,prompt:#a89984,spinner:#e9b143,pointer:#e2cca9,marker:#7c6f64,header:#e2cca9
'

zstyle ':fzf-tab:complete:*' fzf-flags \
    --bind 'focus:transform-header:file --brief {}' \
    --color 'fg:#e2cca9,hl:#a89984,fg+:#e2cca9,bg+:#32302f,hl+:#e2cca9' \
    --color 'info:#83a598,prompt:#a89984,spinner:#e9b143,pointer:#e2cca9,marker:#7c6f64,header:#e2cca9' \
    --preview-window wrap



# zstyle ':fzf-tab:complete:*' fzf-flags --preview-window hidden:wrap
zstyle ':fzf-tab:complete:*' fzf-bindings 'ctrl-/:toggle-preview'


# Groups
zstyle ':fzf-tab:*' single-group color header
zstyle ':fzf-tab:*' show-group full

zstyle ':completion:*' menu no

zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':fzf-tab:*' prefix ''

zstyle ':fzf-tab:*' switch-group '<' '>'

# completions
zstyle ':fzf-tab:*' fzf-bindings 'space:accept'
zstyle ':fzf-tab:*' continuous-trigger '/'

zstyle ':fzf-tab:*' print-query alt-space
zstyle ':fzf-tab:*' accept-line enter

# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no

# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'

# zstyle ':fzf-tab:complete:*:*' fzf-preview 'less ${(Q)realpath}'
export LESSOPEN='|$ZDOTDIR/.lessfilter %s'

zstyle ':fzf-tab:complete:*:options' fzf-preview ''
zstyle ':fzf-tab:complete:*:argument-1' fzf-preview ''


zstyle ":fzf-tab:complete:*:*" fzf-preview '
    if [[ -d "$realpath" ]]; then
        # If Directory   
        less ${(Q)realpath}
    elif [[ -f "$realpath" ]]; then
        # If File
        if $(grep -qI . "$realpath"); then
            bat -p --color=always "$realpath"
        else
            echo "Realpath: $realpath"
            # Use gstat for Linux; fallback to stat for macOS or BSD
            local stat_cmd
            local -a stat_opts
            local arch=$(uname -s)
            if [[ $OSTYPE = darwin* ]]; then
                # Darwin / FreeBSD version
                local gprefix
                command -v gstat &>/dev/null && gprefix=g
                echo "Yes"
                if [[ -z $gprefix ]]; then
                    stat_cmd="stat"
                    stat_opts=(
                    "-f"
                    "File: %N\nLocation: %d:%i\nMode: %Sp (%Mp%Lp)\nLinks: %l\nOwner: %Su/%Sg\nSize: %z (%b blocks)\nChanged: %Sc\nModified: %Sm\nAccessed: %Sa"
                    )
                fi
            else
                # Linux or Darwin with GNU support
                stat_cmd="${gprefix}stat"
                stat_opts=(
                "-c"
                "File: %N\nType: %F\nLocation: %d:%i\nMode: %A (%a)\nLinks: %h\nOwner: %U/%G\nSize: %s (%b blocks)\nChanged: %z\nModified: %y\nAccessed: %x"
                )
            fi

            echo $($stat_cmd "$stat_opts[@]" "$realpath")
        fi
    else
        echo ${(P)word}
    fi
'

# Command specific

# GIT
# disable sort when completing `git checkout`
# zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them

# KILL
# give a preview of commandline arguments when completing `kill`
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
    '[[ $group == "[process ID]" ]] \
        && ps --pid=$word -o cmd --no-headers -w -w'

zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap

# SYSTEMCTL
# Show systemd status
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
