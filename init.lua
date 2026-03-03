vim.g.mapleader = " " -- set space to be the <leader> key
-- deps is non local (global) so other modules main can reference it
Deps = require('plugins.mini_deps')

if not Deps then
  error("deps is nil")
  return
end

require('vanilla.keymaps')
require('vanilla.root')

require('vanilla.commands.rcs')
require('vanilla.commands.gotomodule')

require("vanilla.ui.icons")
require("vanilla.ui.lsp_highlight")
require("vanilla.ui.diagnostic_highlight")
require("vanilla.ui.fold")

require('plugins.colorscheme')
require('plugins.oil')
-- require('plugins.flash')
require('plugins.leap')
require('plugins.snacks')
-- require('plugins.mini_surround')
require('plugins.nvim_surround')
require('plugins.treesitter')
require('plugins.helpview')
require('plugins.mini_icons')
require('plugins.tiny_glimmer')
require('plugins.blink_indent')
require('plugins.rainbow_delimiters')
require('plugins.mini_ai')
require('plugins.mini_pairs')
require("plugins.auto_indent")
-- require("plugins.mini_statusline")
require("plugins.lualine")

require("plugins.lsp.lsp_config")
require("plugins.lsp.lsps")
require("plugins.lsp.conform")
require("plugins.lsp.setup")






vim.o.winwidth = 20
vim.o.winminwidth = 20
vim.o.equalalways = false
vim.o.winborder = "rounded"

vim.opt.rnu = true
vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true -- change later? idk doesn't really matter
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.showbreak = "└─▶"
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.softtabstop = 2
local augroup = vim.api.nvim_create_augroup('user_cmds', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'help', 'man' },
  group = augroup,
  desc = 'Use q to close the window',
  command = 'nnoremap <buffer> q <cmd>quit<cr>'
})

-- vim.api.nvim_create_autocmd('TextYankPost', {
--   group = augroup,
--   desc = 'Highlight on yank',
--   callback = function(event)
--     vim.highlight.on_yank({ higroup = 'Visual', timeout = 200 })
--   end
-- })
