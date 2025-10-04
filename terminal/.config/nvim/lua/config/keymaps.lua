--
-- ░█▀█░█░█░▀█▀░█▄█░░░░░█░░░█▀▀░█▀█░█▀█░█▀▀░▀█▀░█▀▀                        
-- ░█░█░▀▄▀░░█░░█░█░░░▄▀░░░░█░░░█░█░█░█░█▀▀░░█░░█░█                        
-- ░▀░▀░░▀░░▀▀▀░▀░▀░░░▀░░░░░▀▀▀░▀▀▀░▀░▀░▀░░░▀▀▀░▀▀▀    
-- ░█▀▀░█░█░█▀▀░▀█▀░█▀█░█▄█░░░█░█░█▀▀░█░█░█▄█░█▀█░█▀█░█▀▀
-- ░█░░░█░█░▀▀█░░█░░█░█░█░█░░░█▀▄░█▀▀░░█░░█░█░█▀█░█▀▀░▀▀█
-- ░▀▀▀░▀▀▀░▀▀▀░░▀░░▀▀▀░▀░▀░░░▀░▀░▀▀▀░░▀░░▀░▀░▀░▀░▀░░░▀▀▀
--
-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

local opts = { silent = true }

local function opt(desc, others)
  return vim.tbl_extend("force", opts, { desc = desc }, others or {})
end

--Remap space as leader key
vim.keymap.set("", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Shorten function name
local keymap = vim.keymap.set

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
keymap('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
keymap('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
keymap('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
keymap('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
keymap('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

keymap("n", "<Leader>w", function()
    vim.cmd("silent! write!")
    vim.notify("File saved", vim.log.levels.INFO)
end, opt("Save"))

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)

-- pressing C-h,j,k,l will move the cursor in insert mode
keymap("i", "<C-j>", "<Down>", opts)
keymap("i", "<C-k>", "<Up>", opts)
keymap("i", "<C-h>", "<Left>", opts)
keymap("i", "<C-l>", "<Right>", opts)

keymap("v", "p", "P", opts)

-- Quality of Life stuff --
keymap({ "n", "s", "v" }, "<Leader>yy", '"+y', opt("Yank to clipboard"))
keymap({ "n", "s", "v" }, "<Leader>yY", '"+yy', opt("Yank line to clipboard"))
keymap({ "n", "s", "v" }, "<Leader>yp", '"+p', opt("Paste from clipboard"))
keymap({ "n", "s", "v" }, "<Leader>yd", '"+d', opt("Delete into clipboard"))

