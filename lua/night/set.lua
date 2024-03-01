vim.g.mapleader        = " "
vim.opt.list           = true -- make tabs visible
vim.opt.listchars      = "tab:▸·,trail:×" -- visualize tabs and trailing whitespace
vim.opt.cursorline     = true -- highlight the cursor's line
vim.opt.cursorcolumn   = true -- highlight the cursor's column
vim.opt.colorcolumn    = { 80, 120 } -- highlighr the two columns
vim.opt.guicursor      = "" -- don't turn the cursor into a line in insert mode
vim.opt.number         = true -- show line numbers
vim.opt.relativenumber = true -- show relative line numbers
vim.opt.tabstop        = 8 -- 1 tab character appears as 8 spaces in size
vim.opt.softtabstop    = 2 -- number of spaces to be inserted when pressing Tab
vim.opt.shiftwidth     = 2 -- number of spaces to be inserted when indenting with ><
vim.opt.expandtab      = true -- insert tabs instead of spaces when pressing Tab or when indenting with ><
vim.opt.smartindent    = true -- auto-indent when starting a new line
vim.opt.modeline       = true -- enable modeline so that we can execute vim commands in comments at the beginning of files
vim.opt.wrap           = false -- don't wrap lines when they reach the end of the screen
vim.opt.textwidth      = 120 -- wrap text at 120 characters
vim.opt.autowrite      = true -- automatically save any changes made to a buffer before it's hidden
vim.opt.scrolloff      = 3 -- keep at least 3 screen lines above and bellow the cursor
vim.opt.winminwidth    = 0 -- leave no whitespace when maximizing a pane horizontally
vim.opt.winminheight   = 0 -- leave no whitespace when maximizing a pane vertically
vim.opt.laststatus     = 2 -- always-on status line
vim.opt.showmode       = false -- don't show the mode in the status line, we have airline
vim.opt.foldmethod     = "syntax" -- fold on indentation (folding on syntax makes vim slow)
vim.opt.wrapscan       = false -- don't wrap search from EOF to the top
vim.opt.wildmode       = { "longest", "full" }
vim.opt.swapfile       = false
vim.opt.backup         = false
vim.opt.undodir        = os.getenv("RHOME") .. "/.nvim/undodir"
vim.opt.undofile       = true
vim.opt.signcolumn     = "yes"