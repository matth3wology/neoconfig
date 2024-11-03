-- Set tab width to 4 spaces
vim.opt.tabstop = 2      -- Number of spaces that a tab counts for
vim.opt.softtabstop = 2  -- Number of spaces that a tab counts for when editing
vim.opt.shiftwidth = 2   -- Number of spaces to use for each step of (auto)indent
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.modifiable = true

-- Set lines
vim.opt.number = true
vim.opt.relativenumber = true

-- Set Color
vim.opt.syntax = 'on'
vim.cmd('colorscheme cyberdream')

-- Map the Leader key
vim.g.mapleader = ' '

-- Handle Swap Files
vim.opt.swapfile = false
