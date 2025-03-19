return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local telescope = require("telescope")
    telescope.setup {
      defaults = {
        file_ignore_patterns = { "%.cls%-meta%.xml$" },
        preview = {
          treesitter = true,
        },
        layout_strategy = 'horizontal',
        layout_config = { height = 0.75, width = 0.75 },
      },
    }

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', function() builtin.find_files({ no_ignore = true }) end, {})
    -- vim.keymap.set('n', '<leader>gf', function() builtin.git_files({ no_ignore = true }) end, {})
    vim.keymap.set('n', '<C-p>', function() builtin.git_files({ no_ignore = true }) end, {})
    vim.keymap.set('n', '<C-b>', function() builtin.grep_string({ search = "FIXME:" }) end, {})
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    vim.keymap.set("n", "<space>fh", builtin.help_tags)
    vim.keymap.set("n", "<space>fc", function()
      builtin.find_files { cwd = vim.fn.stdpath "config" }
    end)
  end
}
