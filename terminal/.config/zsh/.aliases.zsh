
alias c='clear'
alias vc='code'
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
alias mkdir='mkdir -p'

alias ls='eza'
alias l='eza -lbF --git'
alias ll='eza -lbGF --git'
alias llm='eza -lbGd --git --sort=modified'
alias la='eza -lbhHigUmuSa --time-style=long-iso --git --color-scale'
alias lx='eza -lbhHigUmuSa@ --time-style=long-iso --git --color-scale'

# specialty views
alias lS='eza -1'
alias lt='eza --tree --level=2'
alias lt3='eza --tree --level=3'
alias lt4='eza --tree --level=4'
alias l.="eza -a | grep -E '^\.'"

alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'
