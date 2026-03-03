-- ===== ./lua/plugins/treesitter/init.lua =====

-- IMPORTANT: nvim-treesitter main "does not support lazy-loading"
-- so we load it in Deps.now.
Deps.add({ source = "nvim-treesitter/nvim-treesitter", checkout = "main" })

Deps.add({
  source = "nvim-treesitter/nvim-treesitter-textobjects",
  checkout = "main",
  depends = {
    { source = "nvim-treesitter/nvim-treesitter", checkout = "main" },
  },
})

Deps.now(function()
  -- nvim-treesitter (new API on main)
  local ts = require("nvim-treesitter")

  ts.setup({
    -- Directory to install parsers/queries to (README default)
    install_dir = vim.fn.stdpath("data") .. "/site",
  })

  -- Start treesitter highlighting for common filetypes (add/remove as you like)
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "lua", "rust", "vim", "query", "markdown" },
    callback = function()
      pcall(vim.treesitter.start)
    end,
  })

  -- Treesitter folds (Neovim built-in)
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "lua", "rust", "vim", "query", "markdown" },
    callback = function()
      vim.wo.foldmethod = "expr"
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end,
  })

  -- Your keymaps (select/move/swap) live here
  require("plugins.treesitter.text_objects")

  -- Optional: install parsers (async). Uncomment if you want auto-bootstrap.
  -- ts.install({ "lua", "rust", "vim", "query" }):wait(300000)
end)
