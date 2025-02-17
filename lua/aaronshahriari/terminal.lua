local term_bufnr = nil
local term_win_id = nil
local function toggle_terminal(position, size)
  if term_win_id and vim.api.nvim_win_is_valid(term_win_id) then
    vim.api.nvim_win_close(term_win_id, true)
    term_win_id = nil
  else
    if not term_bufnr or not vim.api.nvim_buf_is_valid(term_bufnr) then
      vim.cmd("new")
      term_bufnr = vim.api.nvim_get_current_buf()
      vim.cmd("term")
    else
      vim.cmd("new")
      vim.api.nvim_win_set_buf(0, term_bufnr)
    end
    vim.cmd("wincmd " .. position)
    if size and position == "J" then
      vim.api.nvim_win_set_height(0, size)
    elseif size and position == "L" then
      vim.api.nvim_win_set_width(0, size)
    end
    term_win_id = vim.api.nvim_get_current_win()
  end
end

vim.keymap.set("n", "<C-g>", function() toggle_terminal("J", 15) end)
vim.keymap.set("n", "<C-p>", function() toggle_terminal("L", 85) end)
