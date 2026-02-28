-- lua/plugins/treesitter_textobjects_keymaps.lua
-- Fully explicit mappings (no loops, no tables generating mappings)

deps.add({
  source = "nvim-treesitter/nvim-treesitter-textobjects",
  depends = {
    { source = "nvim-treesitter/nvim-treesitter" },
  },
})

local ts_select = require("nvim-treesitter-textobjects.select")
local ts_move = require("nvim-treesitter-textobjects.move")
local ts_swap = require("nvim-treesitter-textobjects.swap")
local ts_repeat = require("nvim-treesitter-textobjects.repeatable_move")

-- ---------------------------------------------------------
-- Select textobjects (x = visual, o = operator-pending)
-- ---------------------------------------------------------

-- Function: af / if
vim.keymap.set({ "x", "o" }, "af", function()
  ts_select.select_textobject("@function.outer", "textobjects")
end, { desc = "TS Select: Function outer" })

vim.keymap.set({ "x", "o" }, "if", function()
  ts_select.select_textobject("@function.inner", "textobjects")
end, { desc = "TS Select: Function inner" })

-- Class: ac / ic
vim.keymap.set({ "x", "o" }, "ac", function()
  ts_select.select_textobject("@class.outer", "textobjects")
end, { desc = "TS Select: Class outer" })

vim.keymap.set({ "x", "o" }, "ic", function()
  ts_select.select_textobject("@class.inner", "textobjects")
end, { desc = "TS Select: Class inner" })

-- Parameter: aa / ia
vim.keymap.set({ "x", "o" }, "aa", function()
  ts_select.select_textobject("@parameter.outer", "textobjects")
end, { desc = "TS Select: Param outer" })

vim.keymap.set({ "x", "o" }, "ia", function()
  ts_select.select_textobject("@parameter.inner", "textobjects")
end, { desc = "TS Select: Param inner" })

-- Loop: ao / io
vim.keymap.set({ "x", "o" }, "ao", function()
  ts_select.select_textobject("@loop.outer", "textobjects")
end, { desc = "TS Select: Loop outer" })

vim.keymap.set({ "x", "o" }, "io", function()
  ts_select.select_textobject("@loop.inner", "textobjects")
end, { desc = "TS Select: Loop inner" })

-- Conditional: ad / id
vim.keymap.set({ "x", "o" }, "ad", function()
  ts_select.select_textobject("@conditional.outer", "textobjects")
end, { desc = "TS Select: Conditional outer" })

vim.keymap.set({ "x", "o" }, "id", function()
  ts_select.select_textobject("@conditional.inner", "textobjects")
end, { desc = "TS Select: Conditional inner" })

-- Scope (locals): as / is
-- NOTE: these commonly conflict with Leap's 's' in x/o mode.
vim.keymap.set({ "x", "o" }, "as", function()
  ts_select.select_textobject("@local.scope", "locals")
end, { desc = "TS Select: Scope" })

vim.keymap.set({ "x", "o" }, "is", function()
  ts_select.select_textobject("@local.scope", "locals")
end, { desc = "TS Select: Scope" })

-- Fold: az / iz
vim.keymap.set({ "x", "o" }, "az", function()
  ts_select.select_textobject("@fold", "folds")
end, { desc = "TS Select: Fold" })

vim.keymap.set({ "x", "o" }, "iz", function()
  ts_select.select_textobject("@fold", "folds")
end, { desc = "TS Select: Fold" })

-- ---------------------------------------------------------
-- Swap (README defaults)
-- NOTE: may conflict with other <leader>a mappings.
-- ---------------------------------------------------------
vim.keymap.set("n", "<leader>a", function()
  ts_swap.swap_next("@parameter.inner")
end, { desc = "TS Swap: next parameter" })

vim.keymap.set("n", "<leader>A", function()
  ts_swap.swap_previous("@parameter.outer")
end, { desc = "TS Swap: prev parameter" })

-- ---------------------------------------------------------
-- Movement
-- ---------------------------------------------------------

-- Functions: ]f ]F [f [F
vim.keymap.set({ "n", "x", "o" }, "]f", function()
  ts_move.goto_next_start("@function.outer", "textobjects")
end, { desc = "TS Move: next function start" })

vim.keymap.set({ "n", "x", "o" }, "]F", function()
  ts_move.goto_next_end("@function.outer", "textobjects")
end, { desc = "TS Move: next function end" })

vim.keymap.set({ "n", "x", "o" }, "[f", function()
  ts_move.goto_previous_start("@function.outer", "textobjects")
end, { desc = "TS Move: prev function start" })

vim.keymap.set({ "n", "x", "o" }, "[F", function()
  ts_move.goto_previous_end("@function.outer", "textobjects")
end, { desc = "TS Move: prev function end" })

-- Classes (canonical): ]] ][ [[ []
vim.keymap.set({ "n", "x", "o" }, "]]", function()
  ts_move.goto_next_start("@class.outer", "textobjects")
end, { desc = "TS Move: next class start" })

vim.keymap.set({ "n", "x", "o" }, "][", function()
  ts_move.goto_next_end("@class.outer", "textobjects")
end, { desc = "TS Move: next class end" })

vim.keymap.set({ "n", "x", "o" }, "[[", function()
  ts_move.goto_previous_start("@class.outer", "textobjects")
end, { desc = "TS Move: prev class start" })

vim.keymap.set({ "n", "x", "o" }, "[]", function()
  ts_move.goto_previous_end("@class.outer", "textobjects")
end, { desc = "TS Move: prev class end" })

-- Loop: ]o
vim.keymap.set({ "n", "x", "o" }, "]o", function()
  ts_move.goto_next_start({ "@loop.inner", "@loop.outer" }, "textobjects")
end, { desc = "TS Move: next loop start" })

-- Scope: ]s
-- NOTE: conflicts with Leap if Leap uses 's' in x/o mode.
vim.keymap.set({ "n", "x", "o" }, "]s", function()
  ts_move.goto_next_start("@local.scope", "locals")
end, { desc = "TS Move: next local scope start" })

-- Fold: ]z
vim.keymap.set({ "n", "x", "o" }, "]z", function()
  ts_move.goto_next_start("@fold", "folds")
end, { desc = "TS Move: next fold start" })

-- Conditional (closest edge): ]d [d
vim.keymap.set({ "n", "x", "o" }, "]d", function()
  ts_move.goto_next("@conditional.outer", "textobjects")
end, { desc = "TS Move: next conditional (closest edge)" })

vim.keymap.set({ "n", "x", "o" }, "[d", function()
  ts_move.goto_previous("@conditional.outer", "textobjects")
end, { desc = "TS Move: prev conditional (closest edge)" })

-- ---------------------------------------------------------
-- Repeatable movement (README)
-- ---------------------------------------------------------
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat.repeat_last_move_next, { desc = "TS Repeat: next" })
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat.repeat_last_move_previous, { desc = "TS Repeat: prev" })

vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat.builtin_f_expr, { desc = "TS Repeat: f", expr = true })
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat.builtin_F_expr, { desc = "TS Repeat: F", expr = true })
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat.builtin_t_expr, { desc = "TS Repeat: t", expr = true })
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat.builtin_T_expr, { desc = "TS Repeat: T", expr = true })
