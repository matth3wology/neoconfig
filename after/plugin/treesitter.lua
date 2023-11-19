require 'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    auto_install = true,
    sync_install = false,
    highlight = {
        enable = true
    },
    indent = {
        enable = true
    },
    autotag = {
        enable = true,
    }
}

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }

local autotag = require("nvim-ts-autotag")
autotag.setup()


local autopairs = require('nvim-autopairs')
autopairs.setup({
    disable_filetype = { "TelescopePrompt", "vim" }
})
