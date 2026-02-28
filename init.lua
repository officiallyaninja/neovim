vim.g.mapleader = " " -- set space to be the <leader> key
-- deps is non local (global) so other modules main can reference it
deps = require('mini_deps')

if not deps then
  error("deps is nil")
  return
end

require('keymaps')
local main = require('main')


vim.o.winwidth = 20
vim.o.winminwidth = 20
vim.o.equalalways = false

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

local augroup = vim.api.nvim_create_augroup('user_cmds', {clear = true})

vim.api.nvim_create_autocmd('FileType', {
  pattern = {'help', 'man'},
  group = augroup,
  desc = 'Use q to close the window',
  command = 'nnoremap <buffer> q <cmd>quit<cr>'
})

vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup,
  desc = 'Highlight on yank',
  callback = function(event)
    vim.highlight.on_yank({higroup = 'Visual', timeout = 200})
  end
})
