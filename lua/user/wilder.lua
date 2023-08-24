local wilder = require('wilder')
wilder.setup({ modes = { ':', '/', '?' } })

wilder.set_option('renderer', wilder.wildmenu_renderer({
  highlighter = wilder.basic_highlighter(),
  separator = ' · ',
  left = { ' ', wilder.wildmenu_spinner(), ' ' },
  right = { ' ', wilder.wildmenu_index() },
  wilder.wildmenu_lualine_theme({
    -- highlights can be overriden, see :h wilder#wildmenu_renderer()
    highlights = { default = 'StatusLine' },
    highlighter = wilder.basic_highlighter(),
    separator = ' · ',
  })
}))
