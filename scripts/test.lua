local M = {}

-- Function to wrap all lines in "const test = () => {}"
M.wrap_in_function = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  for i, line in ipairs(lines) do
    lines[i] = "const test = () => { " .. line .. " }"
  end

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
end


M.names_to_functions = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  for i, line in ipairs(lines) do
    local name = vim.trim(line)
    if name ~= "" then
      lines[i] = "const " .. name .. " = () => {}"
    end
  end

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
end


M.get_lines = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  for i, line in ipairs(lines) do
    print(i, line)
  end
end

-- Replace only in the visual block
M.wrap_block = function()
  local func_name = "block"
  local bufnr = vim.api.nvim_get_current_buf()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local start_line = start_pos[2] - 1
  local end_line = end_pos[2]
  local lines = vim.api.nvim_buf_get_lines(bufnr, start_line, end_line, false)
  table.insert(lines, 1, "const " .. func_name .. " = () => {")
  table.insert(lines, "}")
  vim.api.nvim_buf_set_lines(bufnr, start_line, end_line, false, lines)
end

return M
