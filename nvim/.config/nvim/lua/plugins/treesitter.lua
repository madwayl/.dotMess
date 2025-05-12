--
-- ░█▀█░█░█░▀█▀░█▄█░░░░░█░░░█▀█░█░░░█░█░█▀▀░▀█▀░█▀█                        
-- ░█░█░▀▄▀░░█░░█░█░░░▄▀░░░░█▀▀░█░░░█░█░█░█░░█░░█░█                        
-- ░▀░▀░░▀░░▀▀▀░▀░▀░░░▀░░░░░▀░░░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀░▀                        
-- ░▀█▀░█▀▄░█▀▀░█▀▀░█▀▀░▀█▀░▀█▀░▀█▀░█▀▀░█▀▄░░░█▀▀░█▀█░█▀█░█▀▀░▀█▀░█▀▀░░░░░░
-- ░░█░░█▀▄░█▀▀░█▀▀░▀▀█░░█░░░█░░░█░░█▀▀░█▀▄░░░█░░░█░█░█░█░█▀▀░░█░░█░█░░░▄█▄
-- ░░▀░░▀░▀░▀▀▀░▀▀▀░▀▀▀░▀▀▀░░▀░░░▀░░▀▀▀░▀░▀░░░▀▀▀░▀▀▀░▀░▀░▀░░░▀▀▀░▀▀▀░░░░▀░
-- ░█░█░█▀▀░█░█░█▄█░█▀█░█▀█░█▀▀                                            
-- ░█▀▄░█▀▀░░█░░█░█░█▀█░█▀▀░▀▀█                                            
-- ░▀░▀░▀▀▀░░▀░░▀░▀░▀░▀░▀░░░▀▀▀                                            
--
--     ~ Neovim Parser with keybindings for parsed textobjects ~

return {
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require'nvim-treesitter.configs'.setup({

                -- A list of parser names, or "all" (the listed parsers MUST always be installed)
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "javascript", "python", },

                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,

                -- Automatically install missing parsers when entering buffer
                -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
                auto_install = true,

                -- List of parsers to ignore installing (or "all")
                ignore_install = { "" },

                ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
                -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

                highlight = { enable = true, },

                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<Leader>ss", -- set to `false` to disable one of the mappings
                        node_incremental = "<Leader>si",
                        scope_incremental = "<Leader>sc",
                        node_decremental = "<Leader>sd",
                    },
                },

                indent = {
                    enable = true
                },

                  textobjects = {
                    select = {
                        enable = true,

                        -- Automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,

                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            -- You can optionally set descriptions to the mappings (used in the desc parameter of
                            -- nvim_buf_set_keymap) which plugins like which-key display
                            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                            -- You can also use captures from other query groups like `locals.scm`
                            ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
                        },
                        -- You can choose the select mode (default is charwise 'v')
                        --
                        -- Can also be a function which gets passed a table with the keys
                        -- * query_string: eg '@function.inner'
                        -- * method: eg 'v' or 'o'
                        -- and should return the mode ('v', 'V', or '<c-v>') or a table
                        -- mapping query_strings to modes.
                        selection_modes = {
                            ['@parameter.outer'] = 'v', -- charwise
                            ['@function.outer'] = 'V', -- linewise
                            ['@class.outer'] = '<c-v>', -- blockwise
                        },
                        -- If you set this to `true` (default is `false`) then any textobject is
                        -- extended to include preceding or succeeding whitespace. Succeeding
                        -- whitespace has priority in order to act similarly to eg the built-in
                        -- `ap`.
                        --
                        -- Can also be a function which gets passed a table with the keys
                        -- * query_string: eg '@function.inner'
                        -- * selection_mode: eg 'v'
                        -- and should return true or false
                        include_surrounding_whitespace = true,
                    },
                },

                vim.filetype.add({
                    extension = { rasi = "rasi", rofi = "rasi", wofi = "rasi" },
                    filename = {
                        ["vifmrc"] = "vim",
                    },
                    pattern = {
                        [".*/waybar/config"] = "jsonc",
                        [".*/mako/config"] = "dosini",
                        [".*/kitty/.+%.conf"] = "kitty",
                        [".*/hypr/.+%.conf"] = "hyprlang",
                        ["%.env%.[%w_.-]+"] = "sh",
                        [".*/sway/.+%.config"] = "swayconfig"
                    },
                }),
                vim.treesitter.language.register("bash", "kitty") 
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects"
    }
}
