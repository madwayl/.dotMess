# ⌁ ZSH CONFIG ⌁

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Load POsh
eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/my-theme.omp.toml)"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

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
export XDG_CONFIG_HOME=$HOME/.config
export EDITOR=nvim

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
  zinit light jeffreytse/zsh-vi-mode

autoload -Uz compinit && compinit

# Key Bindings
  bindkey -v # Load Vim Key bindings
  bindkey '^p' history-search-backward
  bindkey '^n' history-search-forward

# History configuration
  HISTFILE=~/.histfile
  HISTSIZE=1100000000
  SAVEHIST=1000000000
  HISTDUP=erase

## Enable Options
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