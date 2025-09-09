local fn = vim.fn

-- Location to install Packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- Boostrap Packer if it doesn't exist
if fn.empty(fn.glob(install_path)) > 0 then
  -- Clone the Packer repo to the install_path location
  PACKER_BOOTSTAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })

  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end
-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

-- Packer Modules and Libraries to use
return packer.startup(function(use)
  -- Main packer library
  use('wbthomason/packer.nvim')

  -- Fuzzy Finder window to search through files.
  -- May require ripgrep to be installed for your terminal
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'folke/trouble.nvim' },
      { 'folke/neodev.nvim' },
    },
  }

  -- Treesitter provides syntax highlighting for many languages
  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })

  -- Nvim Tree is a file navigator on the side of the page
  use { 'nvim-tree/nvim-tree.lua',
    requires = {
      { 'nvim-tree/nvim-web-devicons' },
    }
  }

  -- Lualine is a bottom nav to help identify page and file metadata
  use { 'nvim-lualine/lualine.nvim',
    requires = {
      { 'nvim-tree/nvim-web-devicons', opt = true },
    }
  }

  -- Noice is used to update the style of the Search bar
  use {
    'folke/noice.nvim',
    requires = {
      { 'MunifTanjim/nui.nvim' },
      { 'rcarriga/nvim-notify' },
    },
  }

  -- Autotagging and auto pairs
  use('windwp/nvim-ts-autotag')
  use('windwp/nvim-autopairs')
  use { 'm4xshen/autoclose.nvim',
    config = function()
      require("autoclose").setup {
        ["<"] = { escape = true, close = true, pair = "<>" },
      }
    end
  }

  -- Color Libraries & Themes
  use({ 'rose-pine/neovim', as = 'rose-pine' })
  use({ 'folke/tokyonight.nvim', as = 'tokyonight' })
  use({ "catppuccin/nvim", as = "catppuccin" })
  use({ 'hardhackerlabs/theme-vim', as = 'hardhacker' })
  use({ 'thedenisnikulin/vim-cyberpunk', as = 'cyberpunk' })
  use({ 'nyoom-engineering/oxocarbon.nvim', as = 'oxocarbon' })
  use({ 'xiyaowong/transparent.nvim', as = 'transparent' })
  use({ 'scottmckendry/cyberdream.nvim', as = 'cyberdream' })

  -- GUI for things like fuzzy finder
  use { 'ray-x/guihua.lua', run = 'cd lua/fzy && make' }

  --LSP (Langauge Server Protocol)
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    requires = {
      -- LSP Suppport
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
      { "neovim/nvim-lspconfig" },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'L3MON4D3/LuaSnip' },
    }
  }

  -- Linting. Null-ls seems to be deprecated, so try this one out.
  use('mfussenegger/nvim-lint')
  use('mhartington/formatter.nvim')

  -- Goto Preview used to follow code definitions
  use {
    'rmagatti/goto-preview',
    config = function()
      require('goto-preview').setup {
        default_mappings = true,
      }
    end
  }

  -- Logger
  use('rmagatti/logger.nvim')

  -- GO Language support
  use {
    'ray-x/go.nvim',
    config = function()
      require('go').setup()
    end
  }

  -- Git Support, Comments, Etc.
  use {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
    end
  }

  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  use('rhysd/conflict-marker.vim')

  -- Comment support for code
  use {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  }

  -- JSON Formatter
  use('gennaro-tedesco/nvim-jqx')

  -- UFO
  use { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' }
end)
