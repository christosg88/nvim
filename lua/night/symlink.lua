-- open the target of the symlink
vim.api.nvim_create_autocmd("BufRead", {
  desc = "Open symlink target",
  callback = function(event)
    if vim.api.nvim_win_get_option(0, "diff") then
      return
    end

    local resolved = vim.fn.resolve(event.file)
    if resolved == event.file then
      return
    end
    vim.cmd.Bwipeout()
    vim.cmd.edit(resolved)
  end,
  nested = true
})
