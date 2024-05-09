-- open the target of the symlink
vim.keymap.set("n", "<leader>l", function()
  local current_name = vim.api.nvim_buf_get_name(0)
  local resolved = vim.fn.resolve(current_name)
  if resolved == current_name then
    return
  end
  vim.cmd.Bwipeout()
  vim.cmd.edit(resolved)
end
)
