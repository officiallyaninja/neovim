Deps.add({
  source = "neovim/nvim-lspconfig",
})

Deps.now(function()
  require("plugins.lsp.lsps")
end)
