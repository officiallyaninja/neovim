local function keep_bg_set_fg(group, fg_hex)
  local cur = vim.api.nvim_get_hl(0, { name = group, link = false })
  vim.api.nvim_set_hl(0, group, {
    fg = fg_hex,
    bg = cur.bg,      -- preserve colorscheme background (if any)
    sp = cur.sp,      -- preserve special color
    underline = cur.underline,
    undercurl = cur.undercurl,
    italic = cur.italic,
    bold = cur.bold,
  })
end

local function diag_hl()
  keep_bg_set_fg("DiagnosticVirtualTextError", "#ff5555")
  keep_bg_set_fg("DiagnosticVirtualTextWarn",  "#f1fa8c")
  keep_bg_set_fg("DiagnosticVirtualTextInfo",  "#8be9fd")
  keep_bg_set_fg("DiagnosticVirtualTextHint",  "#50fa7b")
end

diag_hl()
vim.api.nvim_create_autocmd("ColorScheme", { callback = diag_hl })
