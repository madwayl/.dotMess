--
-- ░█▀█░█░█░▀█▀░█▄█░░░░░█░░░█▀█░█░░░█░█░█▀▀░▀█▀░█▀█                
-- ░█░█░▀▄▀░░█░░█░█░░░▄▀░░░░█▀▀░█░░░█░█░█░█░░█░░█░█                
-- ░▀░▀░░▀░░▀▀▀░▀░▀░░░▀░░░░░▀░░░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀░▀                
-- ░█░░░█▀▀░█▀█░░░░░░░░░█▀▀░█▀█░█▄█░█▀█░█░░░█▀▀░▀█▀░▀█▀░█▀█░█▀█░█▀▀
-- ░█░░░▀▀█░█▀▀░░░▄█▄░░░█░░░█░█░█░█░█▀▀░█░░░█▀▀░░█░░░█░░█░█░█░█░▀▀█
-- ░▀▀▀░▀▀▀░▀░░░░░░▀░░░░▀▀▀░▀▀▀░▀░▀░▀░░░▀▀▀░▀▀▀░░▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀
--

return {
    {
        "Pocco81/auto-save.nvim",
        opts = {}
    },
    {
        "neovim/nvim-lspconfig",
    },
    {
        "mason-org/mason.nvim",
        opts = {},
    },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = { "mason.nvim", "nvim-lspconfig" },
        opts = {}
    },
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- see the configuration section for more details
                -- load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    { -- optional cmp completion source for require statements and module annotations
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
            opts.sources = opts.sources or {}
            table.insert(opts.sources, {
                name = "lazydev",
                group_index = 0, -- set group index to 0 to skip loading luals completions
            })
        end,
    },
    { -- optional blink completion source for require statements and module annotations
        "saghen/blink.cmp",
          -- optional: provides snippets for the snippet source
        dependencies = { 'rafamadriz/friendly-snippets' },

        -- use a release tag to download pre-built binaries
        version = '1.*',
        opts = {
            sources = {
                -- add lazydev to your completion providers
                default = { "lazydev", "lsp", "path", "snippets", "buffer" },
                providers = {
                    lazydev = {
                        name = "lazydev",
                        module = "lazydev.integrations.blink",
                        -- make lazydev completions top priority (see `:h blink.cmp`)
                        score_offset = 100,
                    },
                },
            },
            fuzzy = { 
                implementation = "lua"
            }
        },
    }
}
