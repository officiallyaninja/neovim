-- Highlight symbol under cursor (LSP documentHighlight)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client or not client.server_capabilities.documentHighlightProvider then
      return
    end

    local group = vim.api.nvim_create_augroup("lsp_document_highlight_" .. ev.buf, { clear = true })

    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = group,
      buffer = ev.buf,
      callback = vim.lsp.buf.document_highlight,
    })

    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "BufLeave" }, {
      group = group,
      buffer = ev.buf,
      callback = vim.lsp.buf.clear_references,
    })
  end,
})
vim.opt.updatetime = 250

-- sets highlight to be underlining instead
--
-- local function set_lsp_reference_hl()
--   vim.api.nvim_set_hl(0, "LspReferenceText",  { underline = true })
--   vim.api.nvim_set_hl(0, "LspReferenceRead",  { underline = true })
--   vim.api.nvim_set_hl(0, "LspReferenceWrite", { underline = true })
-- end

-- set_lsp_reference_hl()
-- vim.api.nvim_create_autocmd("ColorScheme", {
--   callback = set_lsp_reference_hl,
-- })
