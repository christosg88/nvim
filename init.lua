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
  "tpope/vim-fugitive",
  "tpope/vim-surround",
  "mechatroner/rainbow_csv",
  "vim-airline/vim-airline",
  "vim-airline/vim-airline-themes",
  "machakann/vim-highlightedyank",
  { "preservim/vim-markdown",          dependencies = "godlygeek/tabular" },
  "christosg88/vim-night",
  "RRethy/base16-nvim",
  { "aymericbeaumet/vim-symlink",      dependencies = "moll/vim-bbye" },
  { "nvim-telescope/telescope.nvim",   dependencies = "nvim-lua/plenary.nvim" },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- LSP
  { "VonHeikemen/lsp-zero.nvim",       branch = "v3.x" },
  "neovim/nvim-lspconfig",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/nvim-cmp",
  "L3MON4D3/LuaSnip",

  -- Perforce
  { "git@snpsgit.internal.synopsys.com:rihani/vim-perforce.git", enabled = function() return os.getenv("USER") == "gkan" end }

})

vim.g.termdebug_wide = true
vim.api.nvim_create_user_command("Tpt", function()
    vim.cmd.packadd("termdebug")
    vim.cmd.TermdebugCommand(os.getenv("P4_ROOT") .. "/clt/bin-linux64/pt_shell_exec" .. os.getenv("EXEC_MODE"))
  end,
  {}
)
vim.api.nvim_create_user_command("Dbg", function(args)
    vim.cmd.packadd("termdebug")
    vim.cmd.TermdebugCommand(args.args)
  end,
  { nargs = 1 }
)

require("night")
