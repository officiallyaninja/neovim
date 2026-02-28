vim.api.nvim_create_autocmd("BufEnter", {
  callback = function(args)
    local buf = args.buf
    local name = vim.api.nvim_buf_get_name(buf)
    if name == "" then return end

    local root = vim.fs.root(buf, { "Cargo.toml", ".git" })
    if root then
      vim.fn.chdir(root)
    end
  end,
})
