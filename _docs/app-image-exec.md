
Download the official Inkscape AppImage.

Make it executable, run: chmod +x inkscape.AppImage.

Move it to an appropriate path, like ~/.local/bin.

Extract the AppImage, run inkscape.AppImage --appimage-extract; a directory will be created called squashfs-root in the current working directory.

Enter the directory squashfs-root and copy the desktop launcher org.inkscape.Inkscape.desktop to ~/.local/share/applications

Edit the desktop launcher to point to the path of the AppImage followed by %F or %U or %u, i.e., Exec=/home/username/.local/bin/inkscape.AppImage %F

Give the .desktop file executable permissions:

chmod +x ~/.local/share/applications/org.inkscape.Inkscape.desktop

Remove the directory squashfs-root.
