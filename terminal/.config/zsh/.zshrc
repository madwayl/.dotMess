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

source ~/.local/share/zsh/plugins/fzf-tab.plugin.zsh
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source /usr/share/zsh/plugins/zsh-sudo/sudo.plugin.zsh
source /usr/share/zsh/plugins/zsh-autopair/autopair.zsh
source /usr/share/zsh/plugins/zsh-fzf-plugin/fzf.plugin.zsh

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

setopt EXTENDED_HISTORY       # Write the history file in the ':start:elapsed;command' format

setopt INC_APPEND_HISTORY     # Write to the history file immediately, not when the shell exits

setopt SHARE_HISTORY          # Share history between all sessions

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

_load_if_terminal