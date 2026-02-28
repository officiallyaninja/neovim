deps.add({ source = "nvim-mini/mini.surround" })
require("mini.surround").setup({
  mappings = {
    add = "ys",
    delete = "ds",
    replace = "cs",
    find = "yf",
    find_left = "yF",
    highlight = "yh",
    update_n_lines = "yn",
  },
})
