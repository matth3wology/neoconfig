require 'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  auto_install = true,
  sync_install = false,
  highlight = {
    enable = true,
    disable = { 'c', 'rust' }
  },
  indent = {
    enable = true
  },
  autotag = {
    enable = true,
    disable = { 'c', 'rust' },
    enable_rename = true,
    enable_close = true,
    enable_close_on_slash = true,
    filetypes = { "html", "xml", "tsx", "jsx" }
  },
  additional_vim_regex_highlighting = false,
}

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
local autotag = require("nvim-ts-autotag")
autotag.setup()

local autopairs = require('nvim-autopairs')
autopairs.setup({
  disable_filetype = { "TelescopePrompt", "vim" }
})
