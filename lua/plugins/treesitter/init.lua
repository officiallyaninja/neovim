-- ===== ./lua/plugins/treesitter/init.lua =====

Deps.add({ source = "nvim-treesitter/nvim-treesitter", checkout = "main" })

Deps.add({
  source = "nvim-treesitter/nvim-treesitter-textobjects",
  checkout = "main",
  depends = {
    { source = "nvim-treesitter/nvim-treesitter", checkout = "main" },
  },
})

local ts = require("nvim-treesitter")

ts.setup({
  install_dir = vim.fn.stdpath("data") .. "/site",
})

-- Blocklist for filetypes where Tree-sitter is usually pointless or annoying:
-- docs/help buffers, quickfix lists, and health-check output.
local ts_block = { help = true, man = true, qf = true, checkhealth = true }

vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    if ts_block[vim.bo.filetype] then return end
    if not pcall(vim.treesitter.start) then return end

    vim.wo.foldmethod = "expr"
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  end,
})

require("plugins.treesitter.text_objects")

-- Optional: install parsers (async).
ts.install({ "lua", "rust", "vim", "query", "markdown", "python" }):wait(300000)
