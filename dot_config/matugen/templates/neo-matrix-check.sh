#!/usr/bin/env zsh
fpath=("$HOME/.config/zsh/functions" $fpath)
autoload -Uz hex_to_256
echo -1 > $XDG_CACHE_HOME/.color_code

echo $(($(hex_to_256 "{{colors.on_secondary.default.hex}}"))) >> $XDG_CACHE_HOME/.color_code
echo $(($(hex_to_256 "{{colors.on_secondary_fixed_variant.default.hex}}"))) >> $XDG_CACHE_HOME/.color_code
echo $(($(hex_to_256 "{{colors.inverse_primary.default.hex}}"))) >> $XDG_CACHE_HOME/.color_code
echo $(($(hex_to_256 "{{colors.primary.default.hex}}"))) >> $XDG_CACHE_HOME/.color_code
echo $(($(hex_to_256 "{{colors.primary.default.hex}}"))) >> $XDG_CACHE_HOME/.color_code
echo $(($(hex_to_256 "{{colors.on_secondary.default.hex}}"))) >> $XDG_CACHE_HOME/.color_code
echo $(($(hex_to_256 "{{colors.secondary_fixed.default.hex}}"))) >> $XDG_CACHE_HOME/.color_code
echo $(($(hex_to_256 "{{colors.on_primary_container.default.hex}}"))) >> $XDG_CACHE_HOME/.color_code
echo $(($(hex_to_256 "{{colors.secondary_fixed_dim.default.hex}}"))) >> $XDG_CACHE_HOME/.color_code
echo $(($(hex_to_256 "{{colors.on_secondary_container.default.hex}}"))) >> $XDG_CACHE_HOME/.color_code
echo $(($(hex_to_256 "{{colors.secondary_container.default.hex}}"))) >> $XDG_CACHE_HOME/.color_code
echo $(($(hex_to_256 "{{colors.primary.default.hex}}"))) >> $XDG_CACHE_HOME/.color_code
echo $(($(hex_to_256 "{{colors.primary.default.hex}}"))) >> $XDG_CACHE_HOME/.color_code
echo $(($(hex_to_256 "{{colors.primary.default.hex}}"))) >> $XDG_CACHE_HOME/.color_code
