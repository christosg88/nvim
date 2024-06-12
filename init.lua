-- set the leader before loading any plugins
vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local lazy = require("lazy")
lazy.setup({
  "wbthomason/packer.nvim",
  "jiangmiao/auto-pairs",
  "mbbill/undotree",
  "moll/vim-bbye",
  "tpope/vim-fugitive",
  "tpope/vim-surround",
  "mechatroner/rainbow_csv",
  "nvim-lualine/lualine.nvim",
  "machakann/vim-highlightedyank",
  { "preservim/vim-markdown",          dependencies = "godlygeek/tabular" },
  "christosg88/vim-night",
  "RRethy/base16-nvim",
  { "nvim-telescope/telescope.nvim",   dependencies = "nvim-lua/plenary.nvim" },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- LSP
  "neovim/nvim-lspconfig",                -- collection of configurations for built-in LSP client
  "hrsh7th/nvim-cmp",                     -- autocompletion plugin
  "hrsh7th/cmp-nvim-lsp",                 -- LSP source for nvim-cmp
  "hrsh7th/cmp-nvim-lsp-signature-help",  -- nvim-cmp source for displaying function signatures
  "hrsh7th/cmp-path",                     -- filesystem paths source for nvim-cmp
  "hrsh7th/cmp-buffer",                   -- buffer source for nvim-cmp
  "hrsh7th/cmp-cmdline",                  -- buffer source for nvim-cmp
  "hrsh7th/cmp-nvim-lua",                 -- nvim-cmp source for neovim Lua API
  "saadparwaiz1/cmp_luasnip",             -- snippets source for nvim-cmp
  "L3MON4D3/LuaSnip",                     -- snippets plugin

  -- Perforce
  { "git@snpsgit.internal.synopsys.com:rihani/vim-perforce.git", enabled = function() return os.getenv("USER") == "gkan" end }

})

vim.g.termdebug_wide = true
vim.api.nvim_create_user_command("Tpt", function()
    vim.cmd.packadd("termdebug")
    vim.keymap.set({ "n", "v", "i", "t" }, "<c-w>", "<C-\\><C-N><C-w>")
    vim.api.nvim_create_autocmd({ "TermOpen", "WinEnter" }, { pattern = "term://*", command = "startinsert" })
    print("Termdebug " .. os.getenv("P4_ROOT") .. "/clt/bin-linux64/pt_shell_exec" .. os.getenv("EXEC_MODE") .. "...")
    vim.cmd("Termdebug " .. os.getenv("P4_ROOT") .. "/clt/bin-linux64/pt_shell_exec" .. os.getenv("EXEC_MODE"))
  end,
  {}
)
vim.api.nvim_create_user_command("Dbg", function(args)
    vim.cmd.packadd("termdebug")
    vim.keymap.set({ "n", "v", "i", "t" }, "<c-w>", "<C-\\><C-N><C-w>")
    vim.api.nvim_create_autocmd({ "TermOpen", "WinEnter" }, { pattern = "term://*", command = "startinsert" })
    vim.cmd.TermdebugCommand(args.args)
  end,
  { nargs = 1 }
)

require("night")
