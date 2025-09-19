local mason = require('mason')
local lsp = require('lsp-zero')
local mason_config = require('mason-lspconfig')
local mason_tool = require('mason-tool-installer')
local lspconfig = require('lspconfig')
local util = require('lspconfig/util')
local luasnip = require('luasnip')

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load()

require("lint").linters_by_ft = {
  cpp = { 'cpplint' },
  c = { 'cpplint' },
}

lsp.preset("recommended")

lsp.on_attach(function(_, buffnr)
  lsp.default_keymaps({ buffer = buffnr })

  lsp.buffer_autoformat()
end)

-- AutoSave linting
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require('lint').try_lint()
  end
})

mason.setup({
  PATH = "prepend",
})

mason_config.setup({
  ensure_installed = {
    'rust_analyzer',
    'gopls',
    'lua_ls',
    'pyright',
    'ts_ls',
    'eslint',
  },
  automatic_enable = {},
  handlers = {
    lsp.default_setup,
  },
})

mason_tool.setup({
  ensure_installed = {
    'cssls'
  }
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
    ['<CR>'] = cmp.mapping.confirm({
      select = true,
      behavior = cmp.ConfirmBehavior.Insert,
    }),
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
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = 'buffer' },
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

lspconfig.hls.setup {
  capabilities = cmp_lsp.default_capabilities(),
}

lspconfig.rust_analyzer.setup {
  settings = {
    ["rust-analyzer"] = {
      cargo = { allFeatures = true }
    }
  }
}

lspconfig.clojure_lsp.setup {
  cmd = { "clojure-lsp" },
  filetypes = { "clj", "clj", "cljs", "cljr", "cljc", "cljd", "edn" },
  capabilities = cmp_lsp.default_capabilities(),
}

lspconfig.julials.setup {
  capabilities = cmp_lsp.default_capabilities(),
  filetypes = { "jl" },
}

lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {
          'vim',
          'require'
        },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

lspconfig.eslint.setup({
  on_attach = function(client, _)
    client.server_capabilities.documentFormattingProvider = true
    client.server_capabilities.definitionProvider = false
  end,
  on_init = function(client)
    client.server_capabilities.definitionProvider = false
  end,
  settings = {
    format = { enable = true }, -- enable formatting
  }
})

lspconfig.omnisharp.setup({
  cmd = { "omnisharp" }, -- or the full path to the binary
  root_dir = lspconfig.util.root_pattern("*.sln", "*.csproj", ".git"),
  enable_editorconfig_support = true,
  enable_roslyn_analyzers = true,
  organize_imports_on_format = true,
  enable_import_completion = true,
})

lspconfig.clangd.setup {
  cmd = { "clangd", "--compile-commands-dir=build" }
}
