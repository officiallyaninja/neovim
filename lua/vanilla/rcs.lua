local function detect_os()
  -- "Darwin" (macOS), "Linux", "Windows_NT"
  local sys = (vim.uv or vim.loop).os_uname().sysname
  if sys == "Windows_NT" then
    return "windows"
  elseif sys == "Darwin" then
    return "mac"
  else
    return "linux"
  end
end

local function expand(path)
  return vim.fn.expand(path)
end

local function edit(path)
  vim.cmd("edit " .. vim.fn.fnameescape(path))
end

local os = detect_os()

-- Define your RC targets here.
-- Use "~" and $VARS freely; we expand them.
local targets_by_os = {
  mac = {
    zshrc   = "~/.zshrc",
    wezterm = "~/.wezterm.lua",
    ghostty = "~/Library/Application Support/com.mitchellh.ghostty/config",
    nvim    = vim.fn.stdpath("config") .. "/init.lua",
    -- glazewm: not on mac
  },
  linux = {
    zshrc   = "~/.zshrc",
    wezterm = "~/.wezterm.lua",
    ghostty = "~/.config/ghostty/config",
    nvim    = vim.fn.stdpath("config") .. "/init.lua",
    -- glazewm: not on linux typically
  },
  windows = {
    -- adjust paths to your actual setup
    zshrc   = "~/.zshrc", -- if you use zsh via MSYS2/WSL/etc; otherwise remove
    wezterm = "~/AppData/Local/wezterm/wezterm.lua",
    ghostty = "~/AppData/Roaming/ghostty/config",
    glazewm = "~/AppData/Roaming/glazewm/config.yaml",
    nvim    = vim.fn.stdpath("config") .. "/init.lua",
  },
}

local targets = targets_by_os[os] or {}

-- :Rc {name}
vim.api.nvim_create_user_command("Rc", function(cmd)
  local name = cmd.args
  if name == "" then
    vim.notify("Usage: :Rc <" .. table.concat(vim.tbl_keys(targets), "|") .. ">", vim.log.levels.WARN)
    return
  end

  local path = targets[name]
  if not path then
    vim.notify("Unknown rc: " .. name, vim.log.levels.ERROR)
    return
  end

  path = expand(path)
  edit(path)
end, {
  nargs = "?",
  complete = function(arglead)
    local keys = vim.tbl_keys(targets)
    table.sort(keys)
    return vim.tbl_filter(function(k)
      return k:find("^" .. vim.pesc(arglead)) ~= nil
    end, keys)
  end,
})

-- Keymaps (pick whatever you like)
local map = vim.keymap.set
local function map_rc(lhs, name, desc)
  if targets[name] then
    map("n", lhs, function() vim.cmd("Rc " .. name) end, { desc = desc })
  end
end

map_rc("<leader>zsh", "zshrc", "Edit zshrc")
map_rc("<leader>twz", "wezterm", "Edit wezterm config")
map_rc("<leader>gho", "ghostty", "Edit ghostty config")
map_rc("<leader>vim", "nvim", "Edit nvim config")
map_rc("<leader>gwm", "glazewm", "Edit glazewm config")

