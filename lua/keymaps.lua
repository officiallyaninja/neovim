vim.keymap.set("n", "<leader>vim", "<cmd>e $MYVIMRC<cr>") -- open init.lua
vim.keymap.set("n", "<leader>vim", "<cmd>e $MYVIMRC<cr>") -- open init.lua
-- vim.keymap.set("n", "<leader>wez", "<cmd>e C:/Users/Ninja/.wezterm.lua<CR>") -- open init.lua
-- vim.keymap.set("n", "<leader>gwm", "<cmd>e C:/Users/Ninja/.glzr/glazewm/config.yaml<CR>") -- open init.lua
-- vim.keymap.set("n", "<leader>nus", "<cmd>e C:/Users/Ninja/AppData/Roaming/nushell/config.nu<CR>") -- open init.lua
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
vim.keymap.set({ "n", "v" }, "G", "Gzz")
vim.keymap.set({ "n", "v" }, "gg", "ggzz")
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p') -- paste from system clipboard
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P') -- paste from system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y') -- copy to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>Y", '"+Y') -- copy to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>d", '"+d')
vim.keymap.set({ "n", "v" }, "<leader>D", '"+D')
vim.keymap.set("", "<leader>w", "<cmd>w<cr>") -- save
-- vim.keymap.set({ "n", "t" }, "<C-t>", terminal.toggle)
-- vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
-- vim.keymap.set("t", "<C-r>", terminal.restart)
-- vim.keymap.set("c", "<C-j>", "<C-n>", { remap = true })
-- vim.keymap.set("c", "<C-k>", "<C-p>", { remap = true })
vim.keymap.set("n", "<C-_>", "gcc", { remap = true })
vim.keymap.set("x", "<C-_>", "gc", { remap = true })
-- vim.keymap.set("n", "<leader>ff", builtin.find_files)
-- vim.keymap.set("n", "<leader>fS", builtin.lsp_document_symbols)
-- vim.keymap.set("n", "<leader>fs", builtin.lsp_workspace_symbols)
-- vim.keymap.set("n", "<leader>fo", builtin.oldfiles)
-- vim.keymap.set("n", "<leader>fg", builtin.live_grep)
-- vim.keymap.set("n", "<leader>fb", builtin.buffers)
-- vim.keymap.set("n", "<leader>fh", builtin.help_tags)
-- vim.keymap.set("n", "<leader>fc", builtin.commands)
-- vim.keymap.set("n", "<leader>fp", extensions.projects.projects)
vim.keymap.set("i", "<C-BS>", "<C-w>")
