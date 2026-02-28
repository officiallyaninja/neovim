-- lua
vim.lsp.config("lua_ls", {
  cmd = { "lua-language-server" },
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },

})

vim.lsp.enable("lua_ls")

-- rust
vim.lsp.config('rust_analyzer', {
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = false,
      }
    }
  }
})
vim.lsp.enable('rust_analyzer')
