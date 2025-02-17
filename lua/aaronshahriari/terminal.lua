-- function to create term
local term_bufnr = nil
local term_win_id = nil
local function toggle_terminal(position, size)
  if term_win_id and vim.api.nvim_win_is_valid(term_win_id) then
    -- if terminal is open, close it
    vim.api.nvim_win_close(term_win_id, true)
    term_win_id = nil
  else
    if not term_bufnr or not vim.api.nvim_buf_is_valid(term_bufnr) then
      -- create terminal buffer only if it doesn't exist
      vim.cmd("new")                              -- open a new split
      term_bufnr = vim.api.nvim_get_current_buf() -- get the buffer number
      vim.cmd("term")                             -- start terminal in the buffer
    else
      -- open an existing terminal buffer in a new window
      vim.cmd("new")                          -- open a new split
      vim.api.nvim_win_set_buf(0, term_bufnr) -- attach existing buffer
    end
    -- position the terminal window
    vim.cmd("wincmd " .. position) -- move it (j = bottom, l = right)
    if size and position == "J" then
      vim.api.nvim_win_set_height(0, size)
    elseif size and position == "L" then
      vim.api.nvim_win_set_width(0, size)
    end
    -- store the terminal window id
    term_win_id = vim.api.nvim_get_current_win()
  end
end

vim.keymap.set("n", "<C-g>", function() toggle_terminal("J", 15) end)
vim.keymap.set("n", "<C-p>", function() toggle_terminal("L", 85) end)
