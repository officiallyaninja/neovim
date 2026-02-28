Deps.add({
  source = "nvim-treesitter/nvim-treesitter",
  name = "nvim-treesitter",
})

Deps.add({
  source = "nvim-treesitter/nvim-treesitter-textobjects",
  name = "nvim-treesitter-textobjects",
  depends = {
    { source = "nvim-treesitter/nvim-treesitter", name = "nvim-treesitter" },
  },
})

Deps.now(function()
  -- -- Force them onto runtimepath in this session
  -- pcall(vim.cmd, "packadd nvim-treesitter")
  -- pcall(vim.cmd, "packadd nvim-treesitter-textobjects")
  --
  -- local ok, configs = pcall(require, "nvim-treesitter.configs")
  -- if not ok then
  --   vim.notify(
  --     "nvim-treesitter still not on runtimepath.\n"
  --       .. "Look for it here:\n"
  --       .. vim.fn.stdpath("data")
  --       .. "/site/pack/**/(start|opt)/nvim-treesitter\n\n"
  --       .. "runtimepath contains:\n"
  --       .. table.concat(vim.api.nvim_list_runtime_paths(), "\n"),
  --     vim.log.levels.ERROR
  --   )
  --   return
  -- end
  --
  -- configs.setup({
  --   highlight = { enable = true },
  --   indent = { enable = true },
  --   textobjects = {
  --     select = { enable = true, lookahead = true },
  --     move = { enable = true, set_jumps = true },
  --     swap = { enable = true },
  --   },
  -- })
  --
  require("plugins.treesitter.text_objects")
end)
