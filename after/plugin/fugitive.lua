-- vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
vim.keymap.set("n", "<leader>gs", function()
  vim.cmd.Git()
  vim.cmd("resize 15")
end)

local AaronShahriari = vim.api.nvim_create_augroup("AaronShahriari", {})

local autocmd = vim.api.nvim_create_autocmd

autocmd("BufWinEnter", {
  group = AaronShahriari,
  pattern = "*",
  callback = function()
    if vim.bo.ft ~= "fugitive" then
      return
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set("n", "<leader>p", function()
      vim.cmd.Git('push')
      vim.cmd(':q')
    end, opts)

    -- rebase always
    vim.keymap.set("n", "<leader>P", function()
      vim.cmd.Git({ 'pull', '--rebase' })
    end, opts)

    -- NOTE: It allows me to easily set the branch i am pushing and any tracking
    -- needed if i did not set the branch up correctly
    vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts);
  end,
})
