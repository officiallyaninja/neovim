Deps.add({ source = "stevearc/conform.nvim" })

require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    rust = { "rustfmt" },
    python = { "ruff_format" }
  },

  -- Optional: tweak defaults
  -- format_on_save = function(bufnr)
  --   -- Disable for very large files (avoid lag)
  --   local max = 200 * 1024
  --   local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(bufnr))
  --   if ok and stats and stats.size > max then
  --     return
  --   end
  --
  --   return {
  --     timeout_ms = 2000,
  --     lsp_fallback = true, -- if no formatter configured, try LSP formatting
  --   }
  -- end,
})


-- manual format
vim.keymap.set("n", "<leader>r", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format" })
