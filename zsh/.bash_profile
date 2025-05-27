# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs

# Display Managerfirefox  -P
if [ -e /home/mzaql/.nix-profile/etc/profile.d/nix.sh ]; then . /home/mzaql/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
