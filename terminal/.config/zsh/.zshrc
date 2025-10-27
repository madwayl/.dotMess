#
# ░▀▀█░█▀▀░█░█░░░█▀▀░█▀█░█▀█░█▀▀░▀█▀░█▀▀░█░█░█▀▄░█▀█░▀█▀░▀█▀░█▀█░█▀█
# ░▄▀░░▀▀█░█▀█░░░█░░░█░█░█░█░█▀▀░░█░░█░█░█░█░█▀▄░█▀█░░█░░░█░░█░█░█░█
# ░▀▀▀░▀▀▀░▀░▀░░░▀▀▀░▀▀▀░▀░▀░▀░░░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀░▀░░▀░░▀▀▀░▀▀▀░▀░▀
#            ⌁ ZSH CONFIG SOURCED FROM THE INTERNET ⌁
#
# If you come from bash you might have to change your $PATH.

# Load POSH
eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/my-theme.omp.toml)"

autoload -U colors zsh-mime-setup select-word-style

autoload -U compinit; compinit

# autoload -Uz run-help

# (( ${+aliases[run-help]} )) && unalias run-help
# alias help=run-help

# zstyle :compinstall filename '/home/madwayl/.zshrc'
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion:*' rehash true

source /usr/share/zinit/zinit.zsh
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source /usr/share/zsh/plugins/zsh-sudo/sudo.plugin.zsh
source /usr/share/zsh/plugins/zsh-autopair/autopair.zsh
source /usr/share/zsh/plugins/zsh-fzf-plugin/fzf.plugin.zsh

zinit light Aloxaf/fzf-tab
zinit light zuxfoucault/colored-man-pages_mod
zinit light zpm-zsh/colors
zinit light mdumitru/fancy-ctrl-z
zinit light alalik/pycalc

export  LESSHISTFILE=${LESSHISTFILE:-/tmp/less-hist}
export  PARALLEL_HOME="$XDG_CONFIG_HOME/parallel"
export  SCREENRC="$XDG_CONFIG_HOME"/screen/screenrc

export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# History configuration // explicit to not nuke history
export HISTFILE=${HISTFILE:-$ZDOTDIR/.zsh_history}
export HISTSIZE=100000
export SAVEHIST=100000

# Colored man pages (with bat)
export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"
export BITWARDEN_SSH_AUTH_SOCK=$XDG_CONFIG_HOME/.bitwarden-ssh-agent.sock

setopt EXTENDED_HISTORY       # Write the history file in the ':start:elapsed;command' format

setopt INC_APPEND_HISTORY     # Write to the history file immediately, not when the shell exits

# setopt SHARE_HISTORY          # Share history between all sessions

setopt HIST_EXPIRE_DUPS_FIRST # Expire a duplicate event first when trimming history

setopt HIST_IGNORE_DUPS       # Do not record an event that was just recorded again

setopt HIST_IGNORE_ALL_DUPS   # Delete an old recorded event if a new event is a duplicate

setopt APPENDHISTORY        # Enable appending to the history file instead of overwriting it.

setopt HIST_FIND_NO_DUPS     # Prevent the history search from showing duplicate matches.

setopt HIST_IGNORE_SPACE   # Ignore commands that start with a space when saving to history.

setopt HIST_SAVE_NO_DUPS    # Avoid saving duplicate commands to the history file.

setopt HIST_REDUCE_BLANKS   # Remove extra spaces from commands before saving them to history.

setopt HIST_VERIFY   # Show the command for verification before execution when using history expansion.

setopt hist_beep  # Beep when attempting to access a non-existent history entry.

setopt AUTOCD   # Allow changing directories by simply typing the directory name.

setopt EXTENDEDGLOB   # Enable extended globbing features.

setopt NOMATCH # Prevent errors when no matches are found for a glob pattern.

setopt NOTIFY   # Notify when a background job finishes.

function _test_colors {
    source "$ZDOTDIR/.test_color"
}

function _load_if_terminal {
    if [ -t 1 ]; then

        unset -f _load_if_terminal

        source "$ZDOTDIR"/.keybindings.zsh
        source "$ZDOTDIR"/.aliases.zsh
        source "$ZDOTDIR"/.fzf-tab.zsh
    fi
}

function print_centered {
    if [[ $# == 0 ]]; then
        echo "No parameter given" >&2
        echo "Usage: $0 \"<phrase to center>\" \"<1 char to fill empty space>\" [<number of columns>] [<1 char to surround the whole result>" >&2
        return 1
    fi

    declare -i NB_COLS
    if [[ $# -ge 3 ]]; then
        NB_COLS=$3
    else
        NB_COLS="$(tput cols)"
    fi

    #
    if [[ $# -ge 4 ]]; then
        SURROUNDING_CHAR=${4:0:1}
        NB_COLS=$((NB_COLS - 2 ))
    fi

    declare -i str_len="${#1}"

    # Simply displays the text if it exceeds the maximum length
    if [[ $str_len -ge $NB_COLS ]]; then
        echo "$1";
        return 0;
    fi

    # Build the chars to add before and after the given text
    declare -i filler_len="$(( (NB_COLS - str_len) / 2 ))"
    if [[ $# -ge 2 ]]; then
        ch="${2:0:1}"
    else
        ch=" "
    fi
    filler=""
    for (( i = 0; i < filler_len; i++ )); do
        filler="${filler}${ch}"
    done

    printf "%s%s%s%s" "$SURROUNDING_CHAR" "$filler" "$1" "$filler"
    # Add an additional filler char at the end if the result length is not even
    if [[ $(( (NB_COLS - str_len) % 2 )) -ne 0 ]]; then
        printf "%s" "${ch}"
    fi
    printf "%s\n" "${SURROUNDING_CHAR}"
    return 0
}

_load_if_terminal

if [[ "$TERM_PROGRAM" == "ghostty" ]]; then
    source $ZDOTDIR/.colors.zsh
    cbonsai -p -M 8 -b 2 -k $bonsai_list | grep --color=never -E "&|~|_|\)|\.|//"
    echo "\n"

    width="${1:-$(tput cols)}"

    # Capture fortune output
    fortune_output="$(fortune)"

    # Find the longest line length
    max_len=0
    while IFS= read -r line; do
        len=${#line}
        (( len > max_len )) && max_len=$len
    done <<< "$fortune_output"

    # Compute left margin
    margin_width=$(( (width - max_len + 1) / 2 ))
    margin="$(printf "%${margin_width}s" "")"

    # Print each line centered
    while IFS= read -r line; do
        printf "%b%s%s%b\n" "$prim_color" "$margin" "$line" "\033[0m"
    done <<< "$fortune_output"

    echo "\n"
fi

export PATH="$PATH:$CARGO_HOME/bin:$XDG_DATA_HOME/npm/bin"

# ~/.gruvbox_colors.sh — simplified variable names
export color_red="\033[38;5;167m"
export color_orange="\033[38;5;208m"
export color_yellow="\033[38;5;214m"
export color_green="\033[38;5;142m"
export color_aqua="\033[38;5;108m"
export color_blue="\033[38;5;109m"
export color_purple="\033[38;5;175m"
export color_gray="\033[38;5;245m"
export color_fg="\033[38;5;223m"
export color_reset="\033[0m"

function set_title() {
    # $1 = text for title
    echo -ne "\033]0; ${1}\007"
}

# Display shell and PWD when idle, command name when running
function precmd() {
    # Runs right before showing the prompt
    local shell_name=${SHELL##*/}
    local dir_name=$(print -P "%~")  # shorten $HOME to ~
    set_title "${shell_name}: ${dir_name}"
}

function preexec() {
    # Runs right before executing a command
    local cmd=${1%% *}  # Extract command name
    local shell_name=${SHELL##*/}
    local dir_name=$(print -P "%~")
    set_title "${cmd} — ${shell_name}: ${dir_name}"
}

autoload -U add-zsh-hook
add-zsh-hook precmd precmd
add-zsh-hook preexec preexec
