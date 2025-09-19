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
vim.cmd('colorscheme tokyonight-night')

-- Map the Leader key
vim.g.mapleader = ' '

-- Handle Swap Files
vim.opt.swapfile = false

-- Conceal Level
vim.o.conceallevel = 1
vim.api.nvim_set_hl(1, "HelpBar", { link = "Normal" })
vim.api.nvim_set_hl(1, "HelpStar", { link = "Normal" })

vim.lsp.set_log_level("debug")

-- -- User Scripts
-- local test = require("scripts.test")
-- vim.api.nvim_create_user_command("WrapFunc", test.wrap_in_function, {})
-- vim.api.nvim_create_user_command("NameFunc", test.names_to_functions, {})
-- vim.api.nvim_create_user_command("TestLines", test.get_lines, {})
-- vim.api.nvim_create_user_command("TestBlock", test.wrap_block, {})
