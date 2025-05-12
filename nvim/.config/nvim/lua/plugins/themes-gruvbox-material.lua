--
-- ░█▀█░█░█░▀█▀░█▄█░░░░░█░░░█▀█░█░░░█░█░█▀▀░▀█▀░█▀█                
-- ░█░█░▀▄▀░░█░░█░█░░░▄▀░░░░█▀▀░█░░░█░█░█░█░░█░░█░█                
-- ░▀░▀░░▀░░▀▀▀░▀░▀░░░▀░░░░░▀░░░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀░▀                
-- ░▀█▀░█░█░█▀▀░█▄█░█▀▀░░░░░░                                      
-- ░░█░░█▀█░█▀▀░█░█░█▀▀░░░▄▄▄                                      
-- ░░▀░░▀░▀░▀▀▀░▀░▀░▀▀▀░░░░░░                                      
-- ░█▀▀░█▀▄░█░█░█░█░█▀▄░█▀█░█░█░░░░░█▄█░█▀█░▀█▀░█▀▀░█▀▄░▀█▀░█▀█░█░░
-- ░█░█░█▀▄░█░█░▀▄▀░█▀▄░█░█░▄▀▄░▄▄▄░█░█░█▀█░░█░░█▀▀░█▀▄░░█░░█▀█░█░░
-- ░▀▀▀░▀░▀░▀▀▀░░▀░░▀▀░░▀▀▀░▀░▀░░░░░▀░▀░▀░▀░░▀░░▀▀▀░▀░▀░▀▀▀░▀░▀░▀▀▀
--

return {
    {
        "sainnhe/gruvbox-material",
        lazy = false,
        priority = 1000,
        config = function()
            -- Gruvbox-material settings (in Lua)
            vim.g.gruvbox_material_background = "hard"
            vim.g.gruvbox_material_foreground = "mix"
            vim.g.gruvbox_material_enable_bold = 1
            vim.g.gruvbox_material_enable_italic = 1
            vim.g.gruvbox_material_transparent_background = 1
            vim.g.gruvbox_material_better_performance = 1

            -- Apply colorscheme
            vim.cmd("colorscheme gruvbox-material")
        end,
    },
}
