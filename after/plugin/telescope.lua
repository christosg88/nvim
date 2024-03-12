local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<C-p>', function()
  local p4_root = os.getenv("P4_ROOT")
  if p4_root then
    builtin.find_files({
      cwd = p4_root,
      find_command = {
        "fd",
        "-L",
        "--ignore-file=" .. os.getenv("RHOME") .. "/.rg_ignore"
      },
    })
  else
    builtin.find_files({ follow = true })
  end
end, {})
vim.keymap.set('n', '<C-f>', function()
  local p4_root = os.getenv("P4_ROOT")
  if p4_root then
    builtin.live_grep({
      cwd = p4_root,
      additional_args = {
        "-L",
        "--ignore-file=" .. os.getenv("RHOME") .. "/.rg_ignore"
      },
    })
  else
    builtin.find_files({ follow = true })
  end
end, {})
