-- Usage:
--   :GoToModule plugins.oil
--   :GoToModule plugins.lsp.lsps
-- Tab completion is incremental (one dot-section at a time).

vim.api.nvim_create_user_command("GoToModule", function(opts)
  local mod = (opts.args or ""):gsub("^%s+", ""):gsub("%s+$", "")
  if mod == "" then
    vim.notify("Usage: :GoToModule <module.name>", vim.log.levels.ERROR)
    return
  end

  local cfg = vim.fn.stdpath("config")
  local path = cfg .. "/lua/" .. mod:gsub("%.", "/") .. ".lua"
  local dir = vim.fn.fnamemodify(path, ":h")

  vim.fn.mkdir(dir, "p")

  if vim.fn.filereadable(path) == 0 then
    vim.fn.writefile({
      'Deps.add("")',
      'require("").setup()',
      'require("' .. mod .. '")',
    }, path)
  end

  vim.cmd("edit " .. vim.fn.fnameescape(path))
end, {
  nargs = 1,
  complete = function(arglead)
    local lua_root = vim.fn.stdpath("config") .. "/lua/"

    local lead = (arglead or ""):gsub("^%s+", "")
    local prefix, partial = "", lead

    local lastdot = lead:match("^.*()%.")
    if lastdot then
      prefix = lead:sub(1, lastdot)      -- includes trailing "."
      partial = lead:sub(lastdot + 1)
    end

    local dir = lua_root .. prefix:gsub("%.", "/")
    if vim.fn.isdirectory(dir) == 0 then
      return {}
    end

    local out = {}

    -- files -> complete module names
    for _, f in ipairs(vim.fn.glob(dir .. partial .. "*.lua", true, true)) do
      local name = vim.fn.fnamemodify(f, ":t"):gsub("%.lua$", "")
      table.insert(out, prefix .. name)
    end

    -- dirs -> complete "namespace." so you can keep tabbing
    for _, d in ipairs(vim.fn.glob(dir .. partial .. "*", true, true)) do
      if vim.fn.isdirectory(d) == 1 then
        local name = vim.fn.fnamemodify(d, ":t")
        table.insert(out, prefix .. name .. ".")
      end
    end

    table.sort(out)
    return out
  end,
})
