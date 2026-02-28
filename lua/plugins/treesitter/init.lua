-- ===== ./lua/plugins/treesitter/init.lua =====
Deps.add({ source = "nvim-treesitter/nvim-treesitter" })

Deps.add({
  source = "nvim-treesitter/nvim-treesitter-textobjects",
  depends = {
    { source = "nvim-treesitter/nvim-treesitter" },
  },
})

Deps.now(function()
  require("nvim-treesitter.configs").setup({
    highlight = { enable = true },
    indent = { enable = true },

    textobjects = {
      select = { enable = true, lookahead = true },
      move = { enable = true, set_jumps = true },
      swap = { enable = true },
    },
  })

  require("plugins.treesitter.text_objects")
end)
