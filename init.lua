vim.g.mapleader = " " -- set space to be the <leader> key
-- deps is non local (global) so other modules main can reference it
Deps = require('plugins.mini_deps')

if not Deps then
  error("deps is nil")
  return
end

local function load(name)
  local ok, err = xpcall(function()
    require(name)
  end, debug.traceback)

  if not ok then
    vim.notify(
      "Failed loading " .. name .. "\n" .. err,
      vim.log.levels.ERROR
    )
  end
end

load('vanilla.keymaps')
load('vanilla.modified_keymaps')
load('vanilla.root')

load('vanilla.commands.rcs')
load('vanilla.commands.gotomodule')

load("vanilla.ui.icons")
load("vanilla.ui.lsp_highlight")
load("vanilla.ui.diagnostic_highlight")
load("vanilla.ui.fold")
-- load("vanilla.completion")

load('plugins.colorscheme')
load('plugins.oil')
-- load('plugins.flash')
load('plugins.leap')
load('plugins.snacks')
-- load('plugins.mini_surround')
load('plugins.nvim_surround')
load('plugins.treesitter')
load('plugins.helpview')
load('plugins.mini_icons')
load('plugins.tiny_glimmer')
load('plugins.blink_indent')
load('plugins.rainbow_delimiters')
load('plugins.mini_ai')
load('plugins.mini_pairs')
load("plugins.auto_indent")
-- load("plugins.mini_statusline")
load("plugins.lualine")
load("plugins.blink_cmp")
-- load("plugins.noice") -- Try reenabling in the future

load("plugins.lsp.lsp_config")
load("plugins.lsp.lsps")
load("plugins.lsp.conform")
load("plugins.lsp.setup")

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
