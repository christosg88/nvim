local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<C-p>', function()
  local p4_root = os.getenv("P4_ROOT")
  if p4_root then
    builtin.find_files({
      find_command = {
        "fd",
        "-L",
        "--ignore-file=" .. os.getenv("RHOME") .. "/.rg_ignore"
      },
      search_dirs = {p4_root .. "/clt", p4_root .. "/common"}
    })
  else
    builtin.find_files({ follow = true })
  end
end, {})
vim.keymap.set('n', '<C-f>', function()
  local p4_root = os.getenv("P4_ROOT")
  if p4_root then
    builtin.live_grep({
      additional_args = {
        "-L",
        "--ignore-file=" .. os.getenv("RHOME") .. "/.rg_ignore"
      },
      search_dirs = {p4_root .. "/clt", p4_root .. "/common"}
    })
  else
    builtin.live_grep()
  end
end, {})
