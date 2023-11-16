-- Main Configurations
vim.opt.number = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.modifiable = true
vim.opt.relativenumber = true
vim.g.mapleader = " "

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)
--vim.keymap.set('i', '{<CR>', '{<CR>}<C-o>O')

vim.opt.swapfile = false
