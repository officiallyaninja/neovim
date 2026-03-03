Deps.add('stevearc/oil.nvim')

vim.keymap.set("n", "<leader>e", "<cmd>Oil<CR>")

require('oil').setup()
