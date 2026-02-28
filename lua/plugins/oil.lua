Deps.add('stevearc/oil.nvim')

vim.keymap.set("n", "<leader>e", function()
  local root = vim.fs.root(0, { "Cargo.toml", ".git" }) or vim.fn.getcwd()
  vim.cmd("Oil " .. vim.fn.fnameescape(root))
end, { desc = "Oil (project root)" })

require('oil').setup()
