require("leap").add_default_mappings()
vim.keymap.set("o", "z", "<Plug>(leap-forward-to)")
vim.keymap.set("o", "Z", "<Plug>(leap-backward-to)")
vim.keymap.set("", "S", "<Plug>(leap-backward-to)")
