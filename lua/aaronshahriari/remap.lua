vim.g.mapleader = " "
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.g.netrw_bufsettings = "noma nomod nu nowrap ro nobl"
vim.cmd("autocmd FileType netrw set nu")
--
-- Map these to move splits
vim.keymap.set("n", "<C-S-h>", "<C-w>H")
vim.keymap.set("n", "<C-S-j>", "<C-w>J")
vim.keymap.set("n", "<C-S-k>", "<C-w>K")
vim.keymap.set("n", "<C-S-l>", "<C-w>L")

-- Map these to move through splits
vim.keymap.set("n", "<C-h>", "<C-w><C-h>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")

-- Map these to move through tabs
vim.keymap.set("n", "<Left>", "gT")
vim.keymap.set("n", "<Right>", "gt")

-- Map these to move through tabs
vim.keymap.set("n", "<S-Left>", function() vim.cmd("tabmove -1") end)
vim.keymap.set("n", "<S-Right>", function() vim.cmd("tabmove +1") end)

-- quickfix
vim.keymap.set("n", "gl", function() vim.diagnostic.open_float() end)
vim.keymap.set("n", "<C-x>", ":Telescope diagnostics<CR>")

-- Map to change split size
vim.keymap.set("n", "<C-Left>", "<C-w>10<")
vim.keymap.set("n", "<C-Right>", "<C-w>10>")
vim.keymap.set("n", "<C-Up>", "<C-w>10+")
vim.keymap.set("n", "<C-Down>", "<C-w>10-")

-- create splits
vim.keymap.set("n", "<leader>1", "<C-w>v<C-w>l")
vim.keymap.set("n", "<leader>2", "<C-w>s<C-w>j")

-- map all splits set equal
vim.keymap.set("n", "<leader>=", "<C-w>=")

-- Map <leader>-n to open a new tab
vim.keymap.set("n", "<leader>n", "<C-w>T")

-- next greatest remap
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- flip flop visual line blocks
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- get to normal mode in terminal
vim.keymap.set("t", "<ESC>", [[<C-\><C-n>]])

-- run tmux inside of vim
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww ~/.dotfiles/bin/.local/scripts/tmux-sessionizer<CR>")
-- vim.keymap.set("n", "<C-z>", "<cmd>silent !tmux neww ~/.dotfiles/bin/.local/scripts/split-sessionizer<CR>")
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !. ~/.dotfiles/bin/.local/scripts/wezterm-sessionizer<CR>")

vim.keymap.set("n", "<leader>st", function()
  vim.cmd.new()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 12)
end)

-- Define a function for creating a split terminal
vim.keymap.set("n", "<leader>t", function()
  vim.cmd.new()
  vim.cmd.term()
  vim.cmd.wincmd("L")
end)

-- source lua file
vim.keymap.set("n", "<leader><leader>", function()
  vim.cmd("so")
end)
