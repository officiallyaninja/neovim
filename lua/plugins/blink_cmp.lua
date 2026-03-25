MiniDeps.add({
  source = "saghen/blink.cmp",
  depends = { "rafamadriz/friendly-snippets" },
  checkout = "v1.10.1",
})

require("blink.cmp").setup({
  keymap = {
    preset = "none",

    ["<Down>"] = { "select_next", "fallback" },
    ["<Up>"] = { "select_prev", "fallback" },

    ["<Tab>"] = { "accept", "fallback" },
    ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
  },

  appearance = {
    nerd_font_variant = "mono",
  },

  completion = {
    documentation = {
      auto_show = false,
    },
  },

  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },

  fuzzy = {
    implementation = "prefer_rust_with_warning",
  },
})
