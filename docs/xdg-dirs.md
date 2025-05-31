XDG to let all setup config correctly.

xdg_usr_dirs, xdg-portal-desktop, xsettingsd

don't set XDG_RUNTIME_DIR and other dirs in zshrc
set shell with \_SHELL
and other GTK env with \_GTK_THEME

only set below:

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DATA_DIRS="$XDG_DATA_HOME:/usr/local/share:/usr/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

Readings are from xsettingsd, gtk-3.0, gtk-4.0

https://wiki.archlinux.org/title/XDG_user_directories
https://superuser.com/questions/1777746/gtk-theme-settings-not-being-respected
oroginal: https://specifications.freedesktop.org/basedir-spec/latest/

TODO: list packages needed
