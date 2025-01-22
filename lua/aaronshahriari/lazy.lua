local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    "xixiaofinland/sf.nvim",

    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "ibhagwan/fzf-lua",
    },
    config = function()
      require('sf').setup({
        enable_hotkeys = false,
        default_dir = '/force-app/main/default/',
        hotkeys_in_filetypes = {
          "apex", "sosl", "soql", "cls"
        },
      })
      local Sf = require('sf')
      -- remaps
      vim.keymap.set("n", "<leader>aa", Sf.run_anonymous)
      vim.keymap.set("n", "<C-p>", Sf.toggle_term)
      vim.keymap.set("n", "<leader>q", Sf.run_query)
      vim.keymap.set("v", "<leader>q", Sf.run_highlighted_soql, { buffer = true, desc = "SOQL run highlighted text" })
    end
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require('Comment').setup()
    end
  },
  -- {
  --   "saghen/blink.cmp",
  --   dependencies = "rafamadriz/friendly-snippets",
  --   version = "v0.*",
  --   build = 'cargo build --release',
  --   opts = {
  --     keymap = { preset = "default" },
  --     appearance = {
  --       use_nvim_cmp_as_default = true,
  --       nerd_font_variant = "mono"
  --     },
  --     sources = {
  --       default = { "lsp", "path", "snippets", "buffer" },
  --     },
  --   },
  --   opts_extend = { "sources.default" }
  -- },
  {
    "tjdevries/colorbuddy.nvim",
  },
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v4.x",
    dependencies = {
      { "neovim/nvim-lspconfig" },
    }
  },
  { "norcalli/nvim-colorizer.lua" },
  {
    "hrsh7th/nvim-cmp",
    lazy = false,
    priority = 100,
    dependencies = {
      "onsails/lspkind.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
      "saadparwaiz1/cmp_luasnip",
    },
  },
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
    },
  },
  "tpope/vim-surround",
  {
    "chomosuke/term-edit.nvim",
    lazy = false,
    version = '1.*',
  },
  {
    "echasnovski/mini.ai",
    version = "*"
  },

  "nvim-lua/plenary.nvim",

  "numToStr/Comment.nvim",

  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.4",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- new theme
  { "bluz71/vim-moonfly-colors",  name = "moonfly", lazy = false, priority = 1000 },
  {
    "nvim-treesitter/nvim-treesitter",
    tag = "v0.9.2",
    build = ":TSUpdate",
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" }
  },

  "mbbill/undotree",
  "tpope/vim-fugitive",

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },

  "lukas-reineke/indent-blankline.nvim",
})
