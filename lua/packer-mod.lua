-- To update Packer after any changes are installs run:
-- 1) :so
-- 2) :PackerSync

local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
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

-- Use a protected call so we don't error out on first use
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

  --COLORS
  use({ 'rose-pine/neovim', as = 'rose-pine' })
  use({ 'folke/tokyonight.nvim', as = 'tokyonight' })
  use({ "catppuccin/nvim", as = "catppuccin" })
  use({ 'hardhackerlabs/theme-vim', as = 'hardhacker' })
  use({ 'thedenisnikulin/vim-cyberpunk', as = 'cyberpunk' })
  use({ 'xiyaowong/transparent.nvim', as = 'transparent' })

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

  use('jose-elias-alvarez/null-ls.nvim')
  use('nvim-tree/nvim-tree.lua')
  use('nvim-tree/nvim-web-devicons')
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
  use 'ray-x/go.nvim'
  use 'ray-x/guihua.lua'
  use('rmagatti/goto-preview')
  use {
    'folke/noice.nvim',
    requires = {
      { 'MunifTanjim/nui.nvim' },
      { 'rcarriga/nvim-notify' },
    },
  }
  use('lewis6991/gitsigns.nvim')
  use('rhysd/conflict-marker.vim')
  use('numToStr/Comment.nvim')
  use('anuvyklack/pretty-fold.nvim')

  --PlantUML
  use('aklt/plantuml-syntax')
  use {
    'weirongxu/plantuml-previewer.vim',
    requires = {
      { 'tyru/open-browser.vim' }
    }
  }
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })

  use('windwp/nvim-ts-autotag')
  use('windwp/nvim-autopairs')
  use('m4xshen/autoclose.nvim')

  -- Format JSON
  use('gennaro-tedesco/nvim-jqx')

  -- TODO Comments
  use {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  }
end)
