local builtin = require('telescope.builtin')
local trouble = require('trouble.providers.telescope')
local actions = require('telescope.actions')
local telescope = require('telescope')

telescope.load_extension('noice')

telescope.setup {
    defaults = {
        mappings = {
            i = {
                ['<C-t>'] = trouble.open_with_trouble,
                ['<C-n>'] = actions.select_vertical,
                ['<C-p>'] = actions.select_horizontal,
                ['<C-j>'] = actions.move_selection_next,
                ['<C-k>'] = actions.move_selection_previous,
            },
            n = { ['<C-t>'] = trouble.open_with_trouble },
        },
    },
}

vim.keymap.set('n', '<leader>pf', builtin.find_files, {})

vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

vim.keymap.set('n', '<C-p>', builtin.git_files, {})
