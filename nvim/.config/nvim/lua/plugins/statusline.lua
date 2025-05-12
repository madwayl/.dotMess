--
-- ░█▀█░█░█░▀█▀░█▄█░░░░░█░░░█▀█░█░░░█░█░█▀▀░▀█▀░█▀█
-- ░█░█░▀▄▀░░█░░█░█░░░▄▀░░░░█▀▀░█░░░█░█░█░█░░█░░█░█
-- ░▀░▀░░▀░░▀▀▀░▀░▀░░░▀░░░░░▀░░░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀░▀
-- ░█▀▀░▀█▀░█▀█░▀█▀░█░█░█▀▀░█░░░▀█▀░█▀█░█▀▀        
-- ░▀▀█░░█░░█▀█░░█░░█░█░▀▀█░█░░░░█░░█░█░█▀▀        
-- ░▀▀▀░░▀░░▀░▀░░▀░░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀        
--

return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            options = {
                component_separators = { left = '|', right = '|' },
                section_separators = { left = '█▓▒░', right = '░▒▓' },
            },
            sections = {
                lualine_b = {
                    {
                        "diagnostics",
                        symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'},
                    }
                },
                lualine_x = {
                    {
                        "encoding",
                    },
                    {
                        'fileformat',
                        symbols = {
                            unix = 'LF',
                            dos = 'CRLF',
                            mac = 'CR',
                        },
                    },
                    {
                        function()
                            local ft = vim.bo.filetype ~= "" and vim.bo.filetype or "text"
                            local icon = require("nvim-web-devicons").get_icon_by_filetype(ft)
                            return (icon or "") .. "  " .. ft
                        end,
                        padding = { left = 1, right = 1 },
                    },   
                }
            }
        },
    },
}
