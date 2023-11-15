vim.cmd [[packadd packer.nvim]]

local packer = require('packer')

return packer.startup(function(use)
    use('wbthomason/packer.nvim')
    use('folke/trouble.nvim')
    use('lukas-reineke/indent-blankline.nvim')
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.4',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/playground')
    use('theprimeagen/harpoon')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')

    use({
        'rose-pine/neovim',
        as = 'rose-pine',
    })

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            -- LSP Suppport
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            { "neovim/nvim-lspconfig" },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
        }
    }

    use('nvim-tree/nvim-tree.lua')
    use('nvim-tree/nvim-web-devicons')
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    use 'ray-x/go.nvim'
    use 'ray-x/guihua.lua'
    use 'neovim/nvim-lspconfig'

    use('rmagatti/goto-preview')

    use {
        'folke/noice.nvim',
        requires = {
            { 'MunifTanjim/nui.nvim' },
            { 'rcarriga/nvim-notify' },
        },
    }

    use('lewis6991/gitsigns.nvim')
end)
