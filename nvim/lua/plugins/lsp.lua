return {
  {
    'williamboman/mason.nvim',
    keys = { { "<leader>lm", "<cmd>Mason<CR>", desc = "Mason" } },
    opts = {},
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      { 'hrsh7th/cmp-path' },
      { 'L3MON4D3/LuaSnip' },
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ['<A-k>'] = cmp.mapping.select_prev_item(),
          ['<A-j>'] = cmp.mapping.select_next_item(),
          ['<Tab>'] = cmp.mapping.confirm({ select = true }),
          ['<A-i>'] = cmp.mapping.complete(),
          ['<A-f>'] = cmp.mapping.scroll_docs(-4),
        }),
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'nvim_lua' },
          { name = 'path' },
        },
      })
    end
  },

  -- LSP (nvim-lspconfig only ships the server configs; setup uses vim.lsp.config)
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'williamboman/mason-lspconfig.nvim' },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(ev)
          local opts = { buffer = ev.buf, remap = false }

          vim.keymap.set({ "n", "v" }, "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
          vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
          vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
          vim.keymap.set("n", "<leader>t", function() vim.lsp.buf.implementation() end, opts)
          vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
          vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
          vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)
          vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
          vim.keymap.set("n", "<leader>vj", function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)
          vim.keymap.set("n", "<leader>vk", function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
          vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.references() end, opts)
          vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
          vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        end,
      })

      vim.lsp.config('*', {
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
      })

      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            diagnostics = { globals = { 'vim' } }
          }
        }
      })

      -- enables every mason-installed server; jdtls is started by nvim-jdtls in ftplugin/java.lua
      require 'mason-lspconfig'.setup({
        automatic_enable = { exclude = { 'jdtls' } },
      })
    end
  }
  -- Sonarlint
  -- {
  --   "https://gitlab.com/schrieveslaach/sonarlint.nvim.git",
  --   dependencies = { "nvim-telescope/telescope.nvim", },
  --   lazy = true,
  --   ft = {
  --     "python",
  --     "java",
  --     -- "typescript",
  --     -- "javascript",
  --     "go",
  --   },
  --   config = function()
  --     require("sonarlint").setup({
  --       server = {
  --         cmd = {
  --           "sonarlint-language-server",
  --           "-stdio",
  --           "-analyzers",
  --           vim.fn.expand(vim.fn.stdpath 'data' ..
  --             '/mason/packages/sonarlint-language-server/extension/analyzers/sonarjava.jar'),
  --           vim.fn.expand(vim.fn.stdpath 'data' ..
  --             '/mason/packages/sonarlint-language-server/extension/analyzers/sonarpython.jar'),
  --         },
  --         -- vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarpython.jar"),
  --         -- vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarcfamily.jar"),
  --         -- vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjava.jar"),
  --         -- vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjs.jar"),
  --         -- vim.fn.expand("$MASON/share/sonarlint-analyzers/sonargo.jar"),
  --         filetypes = {
  --           "python",
  --           "java",
  --           -- "typescript",
  --           -- "javascript",
  --           "go",
  --         },
  --       },
  --     })
  --   end,
  -- }
}
