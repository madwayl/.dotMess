local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Font settings
config.font = wezterm.font("FantasqueSansM Nerd Font Propo")

config.font_size = 12.5
config.line_height = 1.3

config.window_frame = {
    font      = wezterm.font("FantasqueSansM Nerd Font Propo"),
    font_size = 10,         -- slightly smaller for command palette
}

config.command_palette_font_size = 12
config.command_palette_bg_color = "#181818"

-- Enable ligatures
config.harfbuzz_features = { "calt=1", "clig=1", "liga=1" }

-- Tab bar settings
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true

-- Padding
config.window_padding = {
    left = 32,
    right = 32,
    top = 32,
    bottom = 8,
}

config.window_decorations = "RESIZE"
config.scrollback_lines = 3000

-- Opacity + Blur
config.window_background_opacity = 0.6
config.macos_window_background_blur = 20

-- Cursor
config.default_cursor_style = "BlinkingBlock"

config.colors = require("colors")

-- Dim inactive panes
config.inactive_pane_hsb = {
    saturation = 0.24,
    brightness = 0.5
}



return config