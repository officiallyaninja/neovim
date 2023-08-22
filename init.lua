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
  { 'navarasu/onedark.nvim' },
  { 'folke/tokyonight.nvim' },
  { 'nvim-lualine/lualine.nvim' },
  { 'nvim-tree/nvim-web-devicons' },
  { 'prichrd/netrw.nvim' },
  { 'karb94/neoscroll.nvim' },
  { "lukas-reineke/indent-blankline.nvim" },
  { 'tpope/vim-repeat' },
  { 'nvim-lua/plenary.nvim' },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  { 'nvim-telescope/telescope-fzf-native.nvim',   build = 'make' },
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
  { 'moll/vim-bbye' },
  { 'wellle/targets.vim' },
  { 'ggandor/leap.nvim' },
  { 'nvim-treesitter/nvim-treesitter',            build = ':TSUpdate' },
  { 'HiPhish/nvim-ts-rainbow2' },
  { 'nvim-treesitter/nvim-treesitter-textobjects' },
  { 'williamboman/mason.nvim' },
  { 'stevearc/oil.nvim' },
  { 'neovim/nvim-lspconfig' },
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'L3MON4D3/LuaSnip' },
  { 'saadparwaiz1/cmp_luasnip' },
  { 'rafamadriz/friendly-snippets' },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'kosayoda/nvim-lightbulb' },
  { 'stevearc/dressing.nvim' },
  { 'cohama/lexima.vim' },
})

--user settings files
require("user.leap")


-- setup
require('mason').setup()
require('mason-lspconfig').setup()
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
require("nvim-lightbulb").setup({
  autocmd = { enabled = true }
})

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

local actions = require "telescope.actions"

require('telescope').setup {
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      }
    },
  }
}

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
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']f'] = '@function.outer',
        [']c'] = '@class.outer',
      },
      goto_next_end = {
        [']F'] = '@function.outer',
        [']C'] = '@class.outer',
      },
      goto_previous_start = {
        ['[f'] = '@function.outer',
        ['[c'] = '@class.outer',
      },
      goto_previous_end = {
        ['[F'] = '@function.outer',
        ['[C'] = '@class.outer',
      },
    },
  },
}

-- lsp stuff


vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]] -- format on save

local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

require 'lspconfig'.lua_ls.setup {
  -- ... other configs
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
}
lspconfig.rust_analyzer.setup {}
require('luasnip.loaders.from_vscode').lazy_load()

local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({ name = 'DiagnosticSignError', text = '✘' })
sign({ name = 'DiagnosticSignWarn', text = '▲' })
sign({ name = 'DiagnosticSignHint', text = '⚑' })
sign({ name = 'DiagnosticSignInfo', text = '' })
vim.diagnostic.config({
  virtual_text = {
    severity = { min = vim.diagnostic.severity.ERROR }
  },
  severity_sort = true,
  underline = {
    severity = vim.diagnostic.severity.WARN
  },
  update_in_insert = false,
  float = {
    border = 'rounded',
    source = 'always',
  },
})


local cmp = require('cmp')
local luasnip = require('luasnip')
local select_opts = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp', keyword_length = 1 },
    { name = 'buffer',   keyword_length = 3 },
    { name = 'luasnip',  keyword_length = 2 },
  },
  window = {
    documentation = cmp.config.window.bordered()
  },
  formatting = {
    fields = { 'menu', 'abbr', 'kind' },
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = 'λ',
        luasnip = '⋗',
        buffer = 'Ω',
        path = '🖫',
      }
      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
  mapping = {
    ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
    ['<Down>'] = cmp.mapping.select_next_item(select_opts),

    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),

    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    ['<C-l>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        -- fallback()
      end
    end, { 'i', 's' }),

    ['<C-h>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        -- fallback()
      end
    end, { 'i', 's' }),

    ['<C-j>'] = cmp.mapping(function(fallback)
      local col = vim.fn.col('.') - 1

      if cmp.visible() then
        cmp.select_next_item(select_opts)
      elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        fallback()
      else
        cmp.complete()
      end
    end, { 'i', 's' }),

    ['<C-k>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item(select_opts)
      else
        fallback()
      end
    end, { 'i', 's' }),

  }
})

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
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function(event)
    vim.highlight.on_yank({ higroup = 'Visual', timeout = 200 })
  end
})

vim.api.nvim_create_autocmd('BufWinEnter', {
  callback = function(event)
    vim.opt.rnu = true
    vim.opt.number = true

    vim.cmd(":set signcolumn=yes")
  end
})


vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      local opts = { buffer = true }
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- Displays hover information about the symbol under the cursor
    bufmap('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<cr>')

    -- Jump to the definition
    bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')

    -- Jump to type definition
    bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.type_definition()<cr>')

    -- Renames all references to the symbol under the cursor
    bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.rename()<cr>')

    -- Selects a code action available at the current cursor position
    bufmap('n', '<M-CR>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    bufmap('x', '<M-CR>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')

    -- Show diagnostics in a floating window
    bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

    -- Move to the previous diagnostic
    bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')

    -- Move to the next diagnostic
    bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
  end
})


vim.api.nvim_set_keymap("n", ",m", ':lua require"popui.marks-manager"()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", ",r", ':lua require"popui.references-navigator"()<CR>', { noremap = true, silent = true })


-- remaps
vim.g.mapleader = ' '                                     -- set space to be the <leader> key
vim.keymap.set('n', '<leader>w', '<cmd>w<cr>')            -- save
vim.keymap.set('n', '<leader>q', '<cmd>q<cr>')            -- close buffer
vim.keymap.set('n', '<leader>Q', '<cmd>Bwipeout<cr>')     -- wipeout buffer
vim.keymap.set('n', '<leader>e', '<cmd>Oil<cr>')          -- open netrw file explorer
vim.keymap.set('n', '<leader>s', '<C-w>')                 -- window(split) options
vim.keymap.set('n', '<leader>vim', '<cmd>e $MYVIMRC<cr>') -- open init.lua
vim.keymap.set('n', 'U', '<C-r>')                         -- redo
vim.keymap.set('n', '<C-j>', '<C-w>j')                    -- scroll down
vim.keymap.set('n', '<C-k>', '<C-w>k')                    -- scroll up
vim.keymap.set('n', '<C-l>', '<C-w>l')                    -- scroll down
vim.keymap.set('n', '<C-h>', '<C-w>h')                    -- scroll up


vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p')           -- paste from system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y')           -- copy to system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"+d')           -- cut to system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>j', ']')             -- next <something>
vim.keymap.set({ 'n', 'v' }, '<leader>k', '[')             -- prev <something>
vim.keymap.set({ 'n', 'v' }, 'J', '5j')                    -- scroll down
vim.keymap.set({ 'n', 'v' }, 'K', '5k')                    -- scroll up

vim.keymap.set('', 'H', '^')                               -- move to start of line
vim.keymap.set('', 'L', '$')                               -- move to end of line
vim.keymap.set('', '<leader>m', '@')                       -- call macro

vim.keymap.set({ 'n', 'i' }, '<M-Down>', '<cmd>m .+1<CR>') -- move line down
vim.keymap.set({ 'n', 'i' }, '<M-j>', '<cmd>m .+1<CR>')
vim.keymap.set({ 'n', 'i' }, '<M-Up>', '<cmd>m .-2<CR>')   -- move line up
vim.keymap.set({ 'n', 'i' }, '<M-k>', '<cmd>m .-2<CR>')

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
vim.keymap.set('n', '<leader>t', '<C-w>v<C-w>l<cmd>terminal<CR>')


local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files)
vim.keymap.set('n', '<leader>fo', builtin.oldfiles)
vim.keymap.set('n', '<leader>fg', builtin.live_grep)
vim.keymap.set('n', '<leader>fb', builtin.buffers)
vim.keymap.set('n', '<leader>fh', builtin.help_tags)
