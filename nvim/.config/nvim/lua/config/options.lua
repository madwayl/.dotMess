--
-- ░█▀█░█░█░▀█▀░█▄█░░░░░█░░░█▀▀░█▀█░█▀█░█▀▀░▀█▀░█▀▀                        
-- ░█░█░▀▄▀░░█░░█░█░░░▄▀░░░░█░░░█░█░█░█░█▀▀░░█░░█░█                        
-- ░▀░▀░░▀░░▀▀▀░▀░▀░░░▀░░░░░▀▀▀░▀▀▀░▀░▀░▀░░░▀▀▀░▀▀▀    
-- ░█▀▀░█░█░█▀▀░▀█▀░█▀█░█▄█░░░█▀█░█▀█░▀█▀░▀█▀░█▀█░█▀█░█▀▀
-- ░█░░░█░█░▀▀█░░█░░█░█░█░█░░░█░█░█▀▀░░█░░░█░░█░█░█░█░▀▀█
-- ░▀▀▀░▀▀▀░▀▀▀░░▀░░▀▀▀░▀░▀░░░▀▀▀░▀░░░░▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀
--

-- Set expandtab (convert tabs to spaces)
vim.opt.expandtab = true

-- Set tabstop (how many spaces a tab character occupies visually)
vim.opt.tabstop = 4

-- Set softtabstop (how many spaces a tab will insert or remove in insert mode)
vim.opt.softtabstop = 4

-- Set shiftwidth (how many spaces to use for indentation, like when pressing >> or using auto-indent)
vim.opt.shiftwidth = 4

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "  "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false -- add statusline

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

vim.opt.termguicolors = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.opt.confirm = true


-- Always show the sign column to prevent text shifting when diagnostics or git signs appear
vim.opt.signcolumn = "yes"

-- Allow the cursor to move one character past the end of the line in Normal/Visual modes
vim.opt.virtualedit = "onemore"

-- When line wrapping is enabled, break lines at word boundaries rather than in the middle of a word
vim.opt.linebreak = true

-- Show the tab line only when there are multiple tab pages open (0 = never, 1 = when needed, 2 = always)
vim.opt.showtabline = 1

-- Set the spell-checking language to U.S. English
vim.opt.spelllang = "en_us"

-- Disable line wrapping; long lines will overflow horizontally and require scrolling
vim.opt.wrap = false


