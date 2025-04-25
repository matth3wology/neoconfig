require('formatter').setup({
  filetype = {
    lisp = {
      -- Use an external linter/formatter (e.g., `zpretty`) if installed
      function()
        return {
          exe = "zpretty",
          args = { vim.api.nvim_buf_get_name(0) },
          stdin = true,
        }
      end,
    },
  }
})

-- -- Run on save of a lisp file
-- vim.api.nvim_exec([[
--   augroup FormatAutogroup
--     autocmd!
--     autocmd BufWritePost *.lisp FormatWrite
--   augroup END
-- ]], true)
