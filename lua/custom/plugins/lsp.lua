return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local default_capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    -- Default handlers for LSP
    local default_handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" }),
      -- ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" }),
    }

    -- setup for apex_ls
    lspconfig.apex_ls.setup({
      -- apex_jar_path = '/mnt/c/Users/AaronShahriari/lsp/apex-jorje-lsp.jar',
      apex_jar_path = '/home/ashahriari/lsp/apex-jorje-lsp.jar',
      apex_enable_semantic_errors = false,
      apex_enable_completion_statistics = false,
      filetypes = { "apex", "apexcode", "cls" },
    })

    -- SETUP FOR BASH
    lspconfig.bashls.setup({})

    -- SETUP FOR LUA
    lspconfig.lua_ls.setup({
      handlers = default_handlers,
      capabilities = default_capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' }
          }
        }
      }
    })

    vim.api.nvim_create_autocmd("BufWritePre", {
      -- buffer = buffer,
      callback = function()
        vim.lsp.buf.format { async = false }
      end
    })
  end
}
