vim.api.nvim_create_augroup("UFOHighlights", { clear = true })

vim.api.nvim_create_autocmd("ColorScheme", {
  group = "UFOHighlights",
  callback = function()
    vim.api.nvim_set_hl(0, "UfoFoldedBg", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "UfoPreviewWinBar", { link = "Normal" })
    vim.api.nvim_set_hl(0, "UfoPreviewSbar", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "UfoPreviewThumb", { bg = "NONE" })
  end
})

