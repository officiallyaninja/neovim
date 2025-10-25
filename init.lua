-- TODO:
-- 1. disable auto commenting new lines below commented lines
-- 2. make lualine show the name of folder as well as the current file
-- 3. something to show me the contents of my registers to paste (esp numbered ones)
local lazy = {}

function lazy.install(path)
	if not vim.loop.fs_stat(path) then
		print("Installing lazy.nvim....")
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable", -- latest stable release
			path,
		})
	end
end
function lazy.setup(plugins)
	-- You can "comment out" the line below after lazy.nvim is installed
	lazy.install(lazy.path)
	-- lazy.install(lazy.path)
	vim.opt.rtp:prepend(lazy.path)
	require("lazy").setup(plugins, lazy.opts)
end

lazy.path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
lazy.opts = {
	{ defaults = { lazy = true } },
}

lazy.setup({
	{ "navarasu/onedark.nvim" },
	{ "folke/tokyonight.nvim" },
	{ "nvim-lualine/lualine.nvim" },
	{ "nvim-tree/nvim-web-devicons" },
	{ "prichrd/netrw.nvim" },
	{ "karb94/neoscroll.nvim" },
	{ "lukas-reineke/indent-blankline.nvim" },
	{ "tpope/vim-repeat" },
	{ "nvim-lua/plenary.nvim" },
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.2",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},

	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				--TODO: add Some(), Ok() and Err() for rust files
			})
		end,
	},
	-- { "moll/vim-bbye" },
	{ "wellle/targets.vim" },
	{ "ggandor/leap.nvim" },
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	{ "nvim-treesitter/nvim-treesitter-textobjects" },
	{ "williamboman/mason.nvim" },
	{ "stevearc/oil.nvim" },
	{ "neovim/nvim-lspconfig" },
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "L3MON4D3/LuaSnip" },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "rafamadriz/friendly-snippets" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "kosayoda/nvim-lightbulb" },
	{ "stevearc/dressing.nvim" },
	{
		"numToStr/Comment.nvim",
		lazy = false,
	},
	{ "numToStr/FTerm.nvim" },
	{ "simrat39/rust-tools.nvim" },
	{ "hrsh7th/cmp-cmdline" },
	{ "onsails/lspkind.nvim" },
	{
		"saecki/crates.nvim",
		tag = "v0.3.0",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("crates").setup()
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			highlight = {
				keyword = "fg",
			},
		},
	},
	{
		"akinsho/flutter-tools.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim", -- optional for vim.ui.select
		},
		config = true,
	},
	{
		"stevearc/conform.nvim",
		opts = {},
	},
	{ "ahmedkhalf/project.nvim" },
	{
		"anuvyklack/windows.nvim",
		dependencies = {
			"anuvyklack/middleclass",
			"anuvyklack/animation.nvim",
		},
	},
	{
		"dense-analysis/ale",
		config = function()
			-- Configuration goes here.
			local g = vim.g

			-- g.ale_linters = {
			-- 	rust = { "rustc" },
			-- }
		end,
	},
	{ "tpope/vim-dadbod" },
	{ "windwp/nvim-autopairs" },

	{
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
			"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
		},
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		opts = {
			-- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
			-- animation = true,
			-- insert_at_start = true,
			-- …etc.
		},
		version = "^1.0.0", -- optional: only update when a new 1.x version is released
	},
	{ "RRethy/vim-illuminate" },
	{ "HiPhish/rainbow-delimiters.nvim" },
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
	},
	{ "simrat39/symbols-outline.nvim" },
	{ "kevinhwang91/promise-async" },
	{ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" },
	{ "chaimleib/vim-renpy" },
})
-- end of plugins

-- remaps / keybindings
vim.g.mapleader = " " -- set space to be the <leader> key
vim.keymap.set("n", "<leader>vim", "<cmd>e $MYVIMRC<cr>") -- open init.lua
vim.keymap.set("n", "<leader>wez", "<cmd>e C:/Users/Ninja/.wezterm.lua<CR>") -- open init.lua
vim.keymap.set("n", "<leader>gwm", "<cmd>e C:/Users/Ninja/.glzr/glazewm/config.yaml<CR>") -- open init.lua

vim.keymap.set("n", "U", "<C-r>") -- redo
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-h>", "<C-w>h")

vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "<C-o>", "<C-o>zz")
vim.keymap.set("n", "<C-i>", "<C-i>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

vim.keymap.set({ "n", "v" }, "<leader>p", '"+p') -- paste from system clipboard
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P') -- paste from system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y') -- copy to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>Y", '"+Y') -- copy to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>d", '"+d')
vim.keymap.set({ "n", "v" }, "<leader>D", '"+D')
vim.keymap.set({ "n", "v" }, "G", "Gzz")
vim.keymap.set({ "n", "v" }, "gg", "ggzz")

vim.keymap.set("v", "p", "P")
vim.keymap.set("v", "P", "p")

vim.keymap.set("", "<leader>w", "<cmd>w<cr>") -- save
vim.keymap.set("", "<leader>e", "<cmd>Oil<cr>") -- open netrw file explorer
vim.keymap.set("", "Q", "@") -- call macro

local terminal = require("FTerm")
vim.keymap.set({ "n", "t" }, "<C-t>", terminal.toggle)
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
function terminal:restart()
	terminal.exit()
	terminal.toggle()
end

vim.keymap.set("t", "<C-r>", terminal.restart)

vim.keymap.set("c", "<C-j>", "<C-n>", { remap = true })
vim.keymap.set("c", "<C-k>", "<C-p>", { remap = true })

vim.keymap.set("n", "<C-_>", "gcc", { remap = true })
vim.keymap.set("x", "<C-_>", "gc", { remap = true })

local builtin = require("telescope.builtin")
local extensions = require("telescope").extensions
require("telescope").load_extension("projects")

vim.keymap.set("n", "<leader>ff", builtin.find_files)
vim.keymap.set("n", "<leader>fS", builtin.lsp_document_symbols)
vim.keymap.set("n", "<leader>fs", builtin.lsp_workspace_symbols)

vim.keymap.set("n", "<leader>fo", builtin.oldfiles)
vim.keymap.set("n", "<leader>fg", builtin.live_grep)
vim.keymap.set("n", "<leader>fb", builtin.buffers)
vim.keymap.set("n", "<leader>fh", builtin.help_tags)
vim.keymap.set("n", "<leader>fc", builtin.commands)
vim.keymap.set("n", "<leader>fp", extensions.projects.projects)

vim.keymap.set("i", "<C-BS>", "<C-w>")
--tab stuff
-- Move to previous/next
vim.api.nvim_set_keymap("n", "<A-,>", "<Cmd>BufferPrevious<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-.>", "<Cmd>BufferNext<CR>", { noremap = true, silent = true })
-- Re-order to previous/next
vim.api.nvim_set_keymap("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A->>", "<Cmd>BufferMoveNext<CR>", { noremap = true, silent = true })
-- Goto buffer in position...
vim.api.nvim_set_keymap("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-0>", "<Cmd>BufferLast<CR>", { noremap = true, silent = true })
-- Pin/unpin buffer
vim.api.nvim_set_keymap("n", "<A-p>", "<Cmd>BufferPin<CR>", { noremap = true, silent = true })
-- Close buffer
vim.api.nvim_set_keymap("n", "<leader>q", "<Cmd>BufferClose<CR>", { noremap = true, silent = true })
vim.keymap.set("", "<leader>Q", "<Cmd>close<CR>")
vim.api.nvim_set_keymap("n", "<A-s>", "<Cmd>BufferPick<CR>", { noremap = true, silent = true })

--user settings files
require("user.leap")
require("user.completion")
require("user.ufo")
-- setup
require("mason").setup()
require("mason-lspconfig").setup()
require("nvim-web-devicons").setup()
require("netrw").setup()
require("symbols-outline").setup()
require("lualine").setup({
	sections = {
		lualine_c = { {
			"filename",
			path = 4,
		} },
		lualine_x = { "filetype" },
	},
})

require("onedark").setup({
	style = "cool",
})
require("onedark").load()
-- require("neoscroll").setup()
require("oil").setup({
	view_options = { show_hidden = true },
	keymaps = {
		-- ["<C-h>"] = "actions.select_split",
		-- ["<C-t>"] = "actions.select_tab",
		-- ["<C-l>"] = "actions.refresh",
		["g?"] = "actions.show_help",
		["<CR>"] = "actions.select",
		["<C-s>"] = "actions.select_vsplit",
		["<C-h>"] = false,
		["<C-t>"] = false,
		["<C-p>"] = "actions.preview",
		["<C-c>"] = "actions.close",
		["<C-l>"] = false,
		["<BS>"] = "actions.parent",
		["_"] = "actions.open_cwd",
		["`"] = "actions.cd",
		["~"] = "actions.tcd",
		["gs"] = "actions.change_sort",
		["gx"] = "actions.open_external",
		["g."] = "actions.toggle_hidden",
		["g\\"] = "actions.toggle_trash",
	},
})
require("Comment").setup()
require("telescope").load_extension("fzf")

-- more configured

require("FTerm").setup({
	cmd = "cmd.exe",
})

require("nvim-lightbulb").setup({
	autocmd = { enabled = true },
})

require("nvim-autopairs").setup({
	disable_filetype = { "TelescopePrompt", "vim" },
})

require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
})
TS = require("nvim-treesitter.install")
TS.prefer_git = false
TS.compilers = { "zig", "gcc", "clang" }

require("project_nvim").setup({
	detection_methods = { "pattern", "lsp" },
	patterns = { ".git", ".exercism" },
	silent_chdir = true,
	ignore_lsp = { "lua_ls" },
})

vim.o.winwidth = 20
vim.o.winminwidth = 20
vim.o.equalalways = false
require("windows").setup()

-- theme
vim.opt.termguicolors = true
vim.cmd.colorscheme("onedark")
vim.cmd([[highlight IndentBlanklineContextChar guifg=#C678DD gui=nocombine]])
vim.cmd([[highlight IndentBlanklineContextStart guisp=#C678DD gui=underline]])
vim.g.indent_blankline_buftype_exclude = { "nofile" }

local actions = require("telescope.actions")

require("telescope").setup({
	defaults = {
		-- Default configuration for telescope goes here:
		-- config_key = value,
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
		},
	},
})

require("indent_blankline").setup({
	-- for example, context is off by default, use this to turn it on
	-- space_char_blankline = " ",
	use_treesitter = true,
	show_trailing_blankline_indent = false,
	show_first_indent_level = false,
	show_current_context = true,
	show_current_context_start = false,
})

require("nvim-treesitter.configs").setup({
	rainbow = {
		enable = true,
		-- list of languages you want to disable the plugin for
		-- disable = { 'jsx', 'cpp' },
		-- Which query to use for finding delimiters
		-- query = 'rainbow-parens',
		-- Highlight the entire buffer all at once
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["as"] = "@block.outer",
				["is"] = "@block.inner",
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]f"] = "@function.outer",
				["]c"] = "@class.outer",
			},
			goto_next_end = {
				["]F"] = "@function.outer",
				["]C"] = "@class.outer",
			},
			goto_previous_start = {
				["[f"] = "@function.outer",
				["[c"] = "@class.outer",
			},
			goto_previous_end = {
				["[F"] = "@function.outer",
				["[C"] = "@class.outer",
			},
		},
	},
})

-- lsp stuff

require("conform").setup({
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_fallback = true,
	},
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		python = { "autopep8", "flake8" },
		-- Use a sub-list to run only the first available formatter
		rust = { "rustfmt" },
		javascript = { "prettier" },
		svelte = { "prettier" },
	},
})
-- require("conform").formatters.rustfmt = {
-- 	command = "cargo fmt",
-- }

local lspconfig = require("lspconfig")
lspconfig.pylsp.setup({})
lspconfig.pyright.setup({})

lspconfig.clangd.setup({})
-- vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]] -- format on save

local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities =
	vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

local rt = require("rust-tools")

rt.setup({
	server = {
		on_attach = function(_, bufnr)
			-- Hover actions
			vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
			-- Code action groups
			vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
		end,
	},
})

require("lspconfig").lua_ls.setup({
	-- ... other configs
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

lspconfig.rust_analyzer.setup({})
require("luasnip.loaders.from_vscode").lazy_load()

lspconfig.svelte.setup({
	-- Add filetypes for the server to run and share info between files
	-- filetypes = {
	-- 	--[[ "javascript" , "typescript",]]
	"svelte",
	-- 	"html",
	-- 	"css",
	-- },
})
lspconfig.tailwindcss.setup({})
lspconfig.unocss.setup({})

vim.filetype.add({
	extension = {
		postcss = "css",
	},
})

lspconfig.eslint.setup({
	--- ...
	on_attach = function(client, bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			command = "EslintFixAll",
		})
	end,
})

lspconfig.tsserver.setup({})
-- lspconfig.verible.setup({})

local sign = function(opts)
	vim.fn.sign_define(opts.name, {
		texthl = opts.name,
		text = opts.text,
		numhl = "",
	})
end

sign({ name = "DiagnosticSignError", text = "✘" })
sign({ name = "DiagnosticSignWarn", text = "▲" })
sign({ name = "DiagnosticSignHint", text = "⚑" })
sign({ name = "DiagnosticSignInfo", text = "" })
vim.diagnostic.config({
	virtual_text = {
		severity = { min = vim.diagnostic.severity.ERROR },
	},
	severity_sort = true,
	underline = {
		severity = vim.diagnostic.severity.WARN,
	},
	update_in_insert = false,
	float = {
		border = "rounded",
		source = "always",
	},
})

---- vim-illuminate
-- change the highlight style
-- vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
-- vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
-- vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })

--- auto update the highlight style on colorscheme change
vim.api.nvim_create_autocmd({ "ColorScheme" }, {
	pattern = { "*" },
	callback = function(ev)
		vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
		vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
		vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })
	end,
})
-- testing

-- opts
vim.opt.mouse = "a"
-- vim.opt.autochdir = true
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

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function(event)
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
	callback = function(event)
		vim.opt.rnu = true
		vim.opt.number = true

		vim.cmd(":set signcolumn=yes")
	end,
})

local function show_documentation()
	local filetype = vim.bo.filetype
	if vim.tbl_contains({ "vim", "help" }, filetype) then
		vim.cmd("h " .. vim.fn.expand("<cword>"))
	elseif vim.tbl_contains({ "man" }, filetype) then
		vim.cmd("Man " .. vim.fn.expand("<cword>"))
	elseif vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
		require("crates").show_popup()
	else
		vim.lsp.buf.hover()
	end
end

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function()
		local bufmap = function(mode, lhs, rhs)
			local opts = { buffer = true }
			vim.keymap.set(mode, lhs, rhs, opts)
		end

		-- Displays hover information about the symbol under the cursor
		bufmap("n", "gh", show_documentation)
		-- Jump to the definition
		bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
		-- Jump to type definition
		bufmap("n", "gD", "<cmd>lua vim.lsp.buf.type_definition()<cr>")
		-- Renames all references to the symbol under the cursor
		bufmap("n", "gr", "<cmd>lua vim.lsp.buf.rename()<cr>")
		-- Selects a code action available at the current cursor position
		bufmap({ "n", "i" }, "<CR>", "<cmd>lua vim.lsp.buf.code_action()<cr>")
		bufmap("x", "<CR>", "<cmd>lua vim.lsp.buf.code_action()<cr>")
		-- Show diagnostics in a floating window
		bufmap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
		-- Move to the previous diagnostic
		bufmap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
		-- Move to the next diagnostic
		bufmap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")
	end,
})

-- this start the ahk script
-- will need to be modified if i ever start using linux
vim.api.nvim_create_user_command("CapsLockAHK", function(opts)
	local path = "C:/Users/Ninja/AppData/Local/nvim/non_lua/vim_caps_lock_with_shift.ahk"
	vim.cmd("silent !start " .. path)
end, {})

vim.api.nvim_create_user_command("ChdirToCurrentBuffer", function(opts)
	vim.cmd(":cd %:h")
end, {})

vim.api.nvim_create_user_command("CommitConfig", function(opts)
	-- TODO: change path to a variable
	vim.cmd(
		string.format(
			'!pushd C:\\Users\\Ninja\\AppData\\Local\\nvim && git add . && git commit -m "%s" && git push origin main',
			opts.fargs[1]
		)
	)
end, { nargs = 1 })

vim.api.nvim_create_user_command("FoldAllFunctionsRust", function(opts)
	-- vim.cmd(":%g/ fn /norm zfaf")
	vim.cmd(":%g/ fn /norm ^zfaf")
	vim.cmd(":norm ")
end, {})

vim.api.nvim_set_keymap("n", "zff", "<Cmd>FoldAllFunctionsRust<CR>", { noremap = true, silent = true })
