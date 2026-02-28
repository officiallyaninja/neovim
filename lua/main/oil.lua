MiniDeps.add('stevearc/oil.nvim')

vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>") -- open Oil file explorer

require('oil').setup()
