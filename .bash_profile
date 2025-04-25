# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs

pactl load-module module-switch-on-connect

# Display Managerfirefox  -P
/opt/shikane & shikanectl switch default-off