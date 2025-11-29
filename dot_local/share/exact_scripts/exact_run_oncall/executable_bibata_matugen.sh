#!/bin/bash

BIBATA_DIR="$XDG_CONFIG_HOME/matugen/templates/Bibata-Modern-Matugen-Template"
TMP_DIR="/tmp/Bibata-PNGs"
OUTPUT_DIR="$XDG_DATA_HOME/icons/Bibata-Modern-Matugen/cursors"
LUT="/tmp/lut.png"

lutgen generate -o "$LUT" -n 0 -- "$1" "$2"

mkdir -p "$TMP_DIR"

for dir in "$BIBATA_DIR"/*/; do
    base=$(basename "$dir");
    mkdir -p "$TMP_DIR/$base"
    cd $dir
    for file in *; do
        lutgen apply --hald-clut "$LUT" -o "$TMP_DIR/$base/$file" $file
    done
    cd "$TMP_DIR"
    xcursorgen "$BIBATA_DIR/$base.conf" "$OUTPUT_DIR/$base"
done

rm -rf $TMP_DIR
sed -i 's/xcursor-theme "Bibata-Modern-Matugen"/xcursor-theme "Bibata-Modern-Classic"/' ~/.config/niri/dms/cursor.kdl
sleep 0.5 && sed -i 's/xcursor-theme "Bibata-Modern-Classic"/xcursor-theme "Bibata-Modern-Matugen"/' ~/.config/niri/dms/cursor.kdl

# Notify via DMS toast
dms ipc call toast info "Cursor theme updated"
