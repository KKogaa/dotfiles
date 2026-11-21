return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false, -- the main branch does not support lazy-loading
    build = ":TSUpdate",
    config = function()
      local ts = require("nvim-treesitter")

      ts.setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
      })

      -- Parsers that should always be available.
      ts.install({ "java", "lua", "vim", "vimdoc", "query" })

      -- Replaces the old `auto_install` + `highlight.enable` options: install the
      -- parser for a filetype on demand, then start highlighting the buffer.
      local function start(buf, lang)
        vim.schedule(function()
          if vim.api.nvim_buf_is_valid(buf) then
            vim.treesitter.start(buf, lang)
          end
        end)
      end

      local function on_filetype(buf, ft)
        local lang = vim.treesitter.language.get_lang(ft)
        if not lang then
          return
        end

        if vim.list_contains(ts.get_installed("parsers"), lang) then
          start(buf, lang)
        elseif vim.list_contains(ts.get_available(), lang) then
          ts.install(lang):await(function()
            start(buf, lang)
          end)
        end
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter_highlight", { clear = true }),
        callback = function(ev)
          on_filetype(ev.buf, ev.match)
        end,
      })

      -- Buffers already loaded before this config ran missed the autocmd above.
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) then
          on_filetype(buf, vim.bo[buf].filetype)
        end
      end
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufEnter *.*",
  },
}
