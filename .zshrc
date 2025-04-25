# ⌁ ZSH CONFIG ⌁
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# HL_PRINT_MODE=precmd

# TMOUT=1; TRAPALRM () { zle reset-prompt }

# HL_SEP_MODE='auto'
# HL_SEP=(
#   _PRE  ' ' # consider '┌' or '╭'
#   _LINE ' ' # consider '─'
#   _POST ' ' # consider '┐' or '╮'
# )
# # HL_INFO_MODE='auto'
# # HL_OVERWRITE='on'
# HL_GIT_COUNT_MODE='auto'
# HL_GIT_SEP_SYMBOL='|'
# HL_ERR_MODE='detail'
# HL_CLOCK_SOURCE='date "+%H:%M:%S"'

# HL_LAYOUT_TEMPLATE=(
#   _PRE    "${IS_SSH+ssh }" # shows "ssh " if this is an ssh session
#   USER    '...'
#   HOST    ' at ...'
#   VENV    ' with ...'
#   PATH    ' in ...'
#   _SPACER '' # special, only shows when compact, otherwise fill with space
#   BRANCH  ' on ...'
#   STATUS  ' (...)'
#   _POST   ''
# )

# You may need to manually set your language environment
export LANG=en_US.UTF-8

setopt no_list_beep
setopt auto_list
LISTMAX=0

# Set ZSH Plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Load Zinit
source "$ZINIT_HOME/zinit.zsh"

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

autoload -U compinit && compinit

bindkey -v
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History configuration
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=$HISTSIZE
HISTDUP=erase

# Enable appending to the history file instead of overwriting it.
# This ensures that new commands are added to the history file without erasing existing ones.
setopt appendhistory

# Save timestamps for each command in the history file.
# This allows you to see when each command was executed.
setopt extended_history

# Immediately append commands to the history file as they are executed.
# This ensures that the history file is updated in real-time.
setopt inc_append_history

# Share history between all zsh sessions.
# This allows all open terminals to have a synchronized command history.
setopt share_history

# Expire duplicate entries in the history, keeping the most recent one.
# This helps to reduce clutter in the history file.
setopt hist_expire_dups_first

# Ignore duplicate commands in the history.
# This prevents the same command from being saved multiple times.
setopt hist_ignore_all_dups

# Prevent the history search from showing duplicate matches.
# This ensures that only unique matches are displayed during history search.
setopt hist_find_no_dups

# Ignore commands that start with a space when saving to history.
# This is useful for sensitive commands you don't want saved.
setopt hist_ignore_space

# Avoid saving duplicate commands to the history file.
# This ensures that only unique commands are stored.
setopt hist_save_no_dups

# Remove extra spaces from commands before saving them to history.
# This helps to keep the history file clean and consistent.
setopt hist_reduce_blanks

# Show the command for verification before execution when using history expansion.
# This adds a layer of safety to prevent accidental execution of unintended commands.
setopt hist_verify

# Beep when attempting to access a non-existent history entry.
# This provides an audible alert for invalid history access.
setopt hist_beep

# Allow changing directories by simply typing the directory name.
# This eliminates the need to use the `cd` command explicitly.
setopt autocd

# Enable extended globbing features.
# This allows for more advanced pattern matching in file and directory operations.
setopt extendedglob

# Prevent errors when no matches are found for a glob pattern.
# This avoids unnecessary interruptions in scripts or commands.
setopt nomatch

# Notify when a background job finishes.
# This provides updates on the status of background processes.
setopt notify

autoload -U colors zsh-mime-setup select-word-style

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-Z}={A-Za-z}'
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

zinit cdreplay -q

# Aliases
alias ls='ls --color'

# Shell Integrations
eval "$(fzf --zsh)" # Fuzzy Finder
eval "$(zoxide init --cmd cd zsh)" # Zoxide 'cd'

# 'GOOGLE' Search function
google() {
  search=""
  echo "Googling: $@"
  for term in $@; do
    search="$search%20$term"
  done
  xdg-open "http://www.google.com/search?q=$search"
}

# OMZ Plugins
zi snippet OMZP::git
zi snippet OMZP::cp
zi snippet OMZP::dnf
zi snippet OMZP::docker
zi snippet OMZP::aliases
zi snippet OMZP::gh
zi snippet OMZP::github
zi snippet OMZP::gitignore
zi snippet OMZP::history
zi snippet OMZP::kitty
zi snippet OMZP::man
zi snippet OMZP::npm
zi snippet OMZP::ssh
zi snippet OMZP::sudo
zi snippet OMZP::vscode
zi snippet OMZP::virtualenv
zi snippet OMZP::yum

