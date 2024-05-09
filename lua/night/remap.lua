vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set({"n", "v"}, "<leader>w", vim.cmd.write)

--vim.keymap.set({"n", "v"}, "/", "/\\v")
--vim.keymap.set({"n", "v"}, "?", "?\\v")
--vim.keymap.set({"c", "v"}, "s/", "s/\\v")
--vim.keymap.set("n", "*", "/\\v<<c-r><c-w>><cr>")
--vim.keymap.set("n", "#", "?\\v<<c-r><c-w>><cr>")

vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "<c-u>", "<c-u>zz")
vim.keymap.set("n", "<c-d>", "<c-d>zz")
vim.keymap.set({"n", "v"}, "J", "J0")

vim.keymap.set("v", "<c-J>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<c-K>", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<leader>h", vim.cmd.noh)
vim.keymap.set("n", "<leader>d", ":put =strftime('  %b %d %Y - Christos Gkantidis : ')<CR>")

-- Copy/Paste
vim.keymap.set("v", "p", '"_dp')
vim.keymap.set("v", "P", '"_dP')
vim.keymap.set({"n", "v"}, "<leader>p", '"+p')
vim.keymap.set({"n", "v"}, "<leader>P", '"+P')
vim.keymap.set({"n", "v"}, "<leader>y", '"+y')
vim.keymap.set({"n", "v"}, "<leader>Y", '"+Y')

-- Buffers
vim.keymap.set("n", "<leader><space>", "<c-6>")
vim.keymap.set("n", "<leader>n", vim.cmd.bp)
vim.keymap.set("n", "<leader>m", vim.cmd.bn)

-- Location/Quickfix list
vim.keymap.set("n", "<leader>k", vim.cmd.cprev)
vim.keymap.set("n", "<leader>j", vim.cmd.cnext)

-- Diff
vim.keymap.set("n", "-", "[czz")
vim.keymap.set("n", "+", "]czz")

-- Debugger
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
