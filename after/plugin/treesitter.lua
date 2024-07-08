require 'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  disable = { "systemverilog" },
  auto_install = true,
  sync_install = false,
  highlight = {
    enable = true,
    disable = { 'systemverilog', 'c', 'rust' }
  },
  indent = {
    enable = true
  },
  additional_vim_regex_highlighting = false,
}

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
local autotag = require("nvim-ts-autotag")
autotag.setup({
  filetypes = { "html", "xml", "typescriptreact", "javascriptreact" }
})

local autopairs = require('nvim-autopairs')
autopairs.setup({
  disable_filetype = { "TelescopePrompt", "vim" }
})

require 'nvim-treesitter.install'.compilers = {
  -- Other compilers configurations
  systemverilog = {}, -- Exclude SystemVerilog parser
}
