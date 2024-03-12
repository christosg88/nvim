-- disable LSP log file
vim.lsp.set_log_level("off")

-- add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- setup language servers and add the extra capabilities offered by nvim-cmp
local lspconfig = require("lspconfig")
lspconfig.clangd.setup({ capabilities = capabilities })
lspconfig.rust_analyzer.setup({ capabilities = capabilities })
lspconfig.pylsp.setup({
  capabilities = capabilities,
  settings = {
    pylsp = { plugins = { pycodestyle = { maxLineLength = 120 } } }
  }
})
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
      return
    end

    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT"
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
        }
      }
    })
  end,
  settings = {
    Lua = {}
  }
})

-- luasnip setup
local luasnip = require("luasnip")

-- nvim-cmp setup
local cmp = require("cmp")
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item({ behavior = "insert" })
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item({ behavior = "insert" })
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lsp_signature_help" },
    { name = "path" },
    { name = "buffer" },
    { name = "nvim_lua" },
    { name = "luasnip" },
  },
}

-- `/` cmdline setup.
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
    { name = "nvim_lsp_document_symbol" }
  }
})

-- `:` cmdline setup.
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" }
  }, {
    {
      name = "cmdline",
      option = {
        ignore_cmds = { "Man", "!" }
      }
    }
  })
})

-- map the following keys when the LSP client attaches to an LSP server
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(event)
    -- enable completion triggered by <c-x><c-o>
    vim.bo[event.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
    vim.bo[event.buf].formatexpr = nil

    -- buffer local mappings
    local opts = { buffer = event.buf }
    vim.keymap.set("n", "<f2>", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<f3>", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "<f4>", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "<f5>", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<f6>", vim.diagnostic.setloclist, opts)
    vim.keymap.set("n", "<f7>", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "<f8>", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<f9>",
      function()
        if vim.diagnostic.is_disabled() then
          vim.diagnostic.enable()
        else
          vim.diagnostic.disable()
        end
      end, opts)
    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<leader>f", function() vim.lsp.buf.format({ async = true }) end, opts)
    vim.keymap.set("n", "<leader>s", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", opts)
    vim.keymap.set("n", "<leader>t", "<cmd>Telescope tags<cr>", opts)
    vim.keymap.set("n", "<c-k>", vim.diagnostic.goto_prev)
    vim.keymap.set("n", "<c-j>", vim.diagnostic.goto_next)
    vim.keymap.set("n", "<c-s>", vim.lsp.buf.signature_help)
  end
})
