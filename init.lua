local lazy = {}

function lazy.install(path)
  if not vim.loop.fs_stat(path) then
    print('Installing lazy.nvim....')
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      path,
    })
  end
end

function lazy.setup(plugins)
  -- You can "comment out" the line below after lazy.nvim is installed
  -- lazy.install(lazy.path)

  vim.opt.rtp:prepend(lazy.path)
  require('lazy').setup(plugins, lazy.opts)
end

lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
lazy.opts = {}

lazy.setup({
  {'navarasu/onedark.nvim'},
  {'nvim-lualine/lualine.nvim'},
  {'nvim-tree/nvim-web-devicons'},
  {'prichrd/netrw.nvim'},
  {'karb94/neoscroll.nvim'},
  { "lukas-reineke/indent-blankline.nvim" },
  {'tpope/vim-repeat'},
  {'nvim-lua/plenary.nvim'},
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
  },
  {'moll/vim-bbye'},
  {'wellle/targets.vim'},
  {'ggandor/leap.nvim'},
  {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  {'HiPhish/nvim-ts-rainbow2'},
  {'nvim-treesitter/nvim-treesitter-textobjects'},
  {'williamboman/mason.nvim'},
  {'stevearc/oil.nvim'},
  {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {},
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
  },
})

--user settings files
-- require("user.leap")


-- setup
require('mason').setup()
require('nvim-web-devicons').setup()
require('netrw').setup()
require('lualine').setup()
require('onedark').setup {
    style = 'cool'
}
require('onedark').load()
require('neoscroll').setup()
require("oil").setup()

-- more configured 
require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
  },
  indent = {
    enable = true
  }
})
TS = require('nvim-treesitter.install')
TS.prefer_git = false
TS.compilers = { "gcc", "make" }


-- theme
vim.opt.termguicolors = true
vim.cmd.colorscheme('onedark')
vim.cmd [[highlight IndentBlanklineContextChar guifg=#C678DD gui=nocombine]]
vim.cmd [[highlight IndentBlanklineContextStart guisp=#C678DD gui=underline]]
require("indent_blankline").setup {
  -- for example, context is off by default, use this to turn it on
  -- space_char_blankline = " ",
  use_treesitter = true,
  show_trailing_blankline_indent = false,
  show_first_indent_level = false,
  show_current_context = true,
  show_current_context_start = false,
}

require('nvim-treesitter.configs').setup {
  rainbow = {
    enable = true,
    -- list of languages you want to disable the plugin for
    -- disable = { 'jsx', 'cpp' },
    -- Which query to use for finding delimiters
    query = 'rainbow-parens',
    -- Highlight the entire buffer all at once
    strategy = require('ts-rainbow').strategy.global,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
        ['as'] = '@block.outer',
        ['is'] = '@block.inner',
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
      }
    },
  },
}




-- opts
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true -- change later? idk doesn't really matter

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function(event)
    vim.highlight.on_yank({higroup = 'Visual', timeout = 200})
  end
})

vim.api.nvim_create_autocmd('BufWinEnter', {
  callback = function(event)
    vim.opt.rnu = true
  end
})


-- remaps
vim.g.mapleader = ' '                                     -- set space to be the <leader> key
vim.keymap.set('n', '<leader>w', '<cmd>w<cr>')            -- save
vim.keymap.set('n', '<leader>q', '<cmd>q<cr>')            -- close buffer
vim.keymap.set('n', '<leader>Q', '<cmd>Bwipeout<cr>')     -- wipeout buffer
vim.keymap.set('n', '<leader>e', '<cmd>Oil<cr>')      -- open netrw file explorer
vim.keymap.set('n', '<leader>s', '<C-w>')                 -- window(split) options
vim.keymap.set('n', '<CR>', 'o<ESC>')                     -- newline on enter in normal mode
vim.keymap.set('n', '<S-CR>', 'O<ESC>')
vim.keymap.set('n', '<leader>vim', '<cmd>e $MYVIMRC<cr>') -- open init.lua
vim.keymap.set('n', 'J', '<C-d>', {remap = true})         -- scroll down
vim.keymap.set('n', 'K', '<C-u>', {remap = true})         -- scroll up

vim.keymap.set({'n', 'v'}, '<leader>p', '"+p')            -- paste from system clipboard
vim.keymap.set({'n', 'v'}, '<leader>y', '"+y')            -- copy to system clipboard
vim.keymap.set({'n', 'v'}, '<leader>d', '"+d')            -- cut to system clipboard
vim.keymap.set({'n', 'v'}, '<leader>j', ']')              -- next <something>
vim.keymap.set({'n', 'v'}, '<leader>k', '[')              -- prev <something>

vim.keymap.set('', 'H', '^')                              -- move to start of line
vim.keymap.set('', 'L', '$')                              -- move to end of line
vim.keymap.set('', '<leader>m', '@')                      -- call macro

vim.keymap.set({'n', 'i'}, '<M-Down>', '<cmd>m .+1<CR>')  -- move line down
vim.keymap.set({'n', 'i'}, '<M-j>', '<cmd>m .+1<CR>')
vim.keymap.set({'n', 'i'}, '<M-Up>', '<cmd>m .-2<CR>')    -- move line up
vim.keymap.set({'n', 'i'}, '<M-k>', '<cmd>m .-2<CR>')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files)
vim.keymap.set('n', '<leader>fo', builtin.oldfiles)
vim.keymap.set('n', '<leader>fg', builtin.live_grep)
vim.keymap.set('n', '<leader>fb', builtin.buffers)
vim.keymap.set('n', '<leader>fh', builtin.help_tags)


require('telescope').load_extension('fzf')



