local lualine = require("lualine")
lualine.setup({
  options = {
    theme = "codedark"
  },
  sections = {
    lualine_b = {'branch', 'diff'},
    lualine_c = {
      {
        "filename",
        path = 1
      }
    },
    lualine_y = {'diagnostics', 'progress'},
  }
})
