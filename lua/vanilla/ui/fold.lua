-- ===== Pretty folds (drop anywhere after vim.opt exists, e.g. init.lua or vanilla/ui) =====

-- Behavior: don't auto-close folds
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

-- UI: fold column + nice glyphs (swap to ASCII if your font isn't patched)
vim.opt.foldcolumn = "1"
vim.opt.fillchars = {
  foldopen = "",
  foldclose = "",
  foldsep = " ",
  fold = " ",
  eob = " ",
}


-- Better fold text: "first meaningful line ...    N lines" right-aligned
local function FoldText()
  local line = vim.fn.getline(vim.v.foldstart)
  line = line:gsub("\t", "  "):gsub("^%s+", ""):gsub("%s+$", "")

  local lines = vim.v.foldend - vim.v.foldstart + 1
  local suffix = string.format("    %d lines", lines)

  local win_width = vim.api.nvim_win_get_width(0)
  local suf_w = vim.fn.strdisplaywidth(suffix)
  local max_line_w = math.max(0, win_width - suf_w - 2)

  if vim.fn.strdisplaywidth(line) > max_line_w then
    line = vim.fn.strcharpart(line, 0, math.max(0, max_line_w - 1)) .. "…"
  end

  local pad = math.max(1, max_line_w - vim.fn.strdisplaywidth(line))
  return line .. string.rep(" ", pad) .. suffix
end


_G.FoldText = FoldText
vim.opt.foldtext = "v:lua.FoldText()"

-- Optional: subtle highlights
vim.api.nvim_set_hl(0, "Folded", { italic = true })
vim.api.nvim_set_hl(0, "FoldColumn", { link = "LineNr" })
