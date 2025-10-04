
local M = require("themes.gruvbox-material")
local addon = require("themes.addon-colors")

colors = {
    foreground = "#ebdbb2",
    background = "#000",

    cursor_bg = M['fg0'],
    cursor_border = M['fg0'],
    cursor_fg = "#282828",

    selection_bg = addon.accent,
    selection_fg = addon.bg_accent,

    ansi = {
        M["bg0"],    -- black   (#1d2021)
        M["red"],    -- red     (#f2594b)
        M["green"],  -- green   (#b0b846)
        M["yellow"], -- yellow  (#e9b143)
        M["blue"],   -- blue    (#80aa9e)
        M["purple"], -- magenta (#d3869b)
        M["aqua"],   -- cyan    (#8bba7f)
        M["gray"],   -- white   (#c1bfb8)
    },

    brights = {
        M["grey1"],  -- bright black   (#928374)
        M["bg-red"], -- bright red     (#db4740)
        M["bg-green"],-- bright green  (#b0b846 but background tone)
        M["bg-yellow"],-- bright yellow (#e9b143)
        M["bg-blue"], -- bright blue   (#80aa9e)
        M["bg-purple"],-- bright magenta (#d3869b)
        M["bg-aqua"], -- bright cyan   (#8bba7f)
        M["fg0"],    -- bright white   (#e2cca9)
    },

    -- Tab bar colors
    tab_bar = {
        background = M["bg0"],

        active_tab = {
            bg_color  = addon.accent,
            fg_color  = M["bg1"],
            intensity = "Bold",
        },

        inactive_tab = {
            bg_color = M["bg0"],
            fg_color = M["grey2"],
        },

        inactive_tab_hover = {
            bg_color = M["bg5"],
            fg_color = M["o-white"],
        },

        new_tab = {
            bg_color = M["bg0"],
            fg_color = M["o-white"],
        },

        inactive_tab_edge = addon.bg_accent,
    },

}

return colors