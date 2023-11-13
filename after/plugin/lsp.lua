local lsp = require('lsp-zero')
local mason = require('mason')
local mason_config = require('mason-lspconfig')
local lspconfig = require('lspconfig')
local util = require('lspconfig/util')
local luasnip = require('luasnip')

require("luasnip.loaders.from_vscode").lazy_load()

lsp.preset("recommended")

lsp.on_attach(function(_, buffnr)
    lsp.default_keymaps({ buffer = buffnr })

    lsp.buffer_autoformat()
end)

mason.setup({
    PATH = "prepend",
})

mason_config.setup({
    ensure_installed = {
        'eslint',
        'rust_analyzer',
        'gopls',
        'lua_ls',
        'pylsp',
        'pyright',
    },
    handlers = {
        lsp.default_setup,
    },
})


local cmp = require('cmp')
local cmp_lsp = require('cmp_nvim_lsp')


cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" })
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }),
    window = {
        documentation = cmp.config.window.bordered(),
        completion = cmp.config.window.bordered({
            winhighlight = 'Normal:CmpPmenu,CursorLine:PmenuSel,Search:None'
        }),
    },
})

lspconfig.gopls.setup {
    cmd = { "gopls" },
    capabilities = cmp_lsp.default_capabilities(),
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_dir = util.root_pattern("go.mod", ".git"),
    settings = {
        gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
                unusedParameters = true,
            },
        },
    },
}

lspconfig.pylsp.setup {
    cmd = { "pylsp" },
    capabilities = cmp_lsp.default_capabilities(),
    filetypes = { "py" },
    root_dir = util.root_pattern("main.py", ".git"),
    settings = {
        gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
                unusedParameters = true,
            },
        },
    },
}
