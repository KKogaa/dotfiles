return {
  "nvim-telescope/telescope.nvim",
  version = "^0.2", -- 0.1.x (frozen since 2024) breaks file previews with current nvim-treesitter
  dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-ui-select.nvim" },
  cmd = "Telescope", -- also load when :Telescope is typed, not only from the keys below
  keys = {
    { "<C-p>", "<cmd>Telescope git_files<CR>" },
    { "<leader>pf", "<cmd>Telescope find_files<CR>" },
    { "<leader>pb", "<cmd>Telescope buffers<CR>" },
    { "<leader>ps", "<cmd>Telescope live_grep<CR>" },
    { "<leader>vh", "<cmd>Telescope help_tags<CR>" },
    { "<leader>prr","<cmd>Telescope lsp_references<CR>" },
    { "<leader>pg", "<cmd>Telescope git_commits<CR>" },
    { "<leader>pd", "<cmd>Telescope diagnostics<CR>" },
  },
  config = function ()
    local telescope = require("telescope")
    telescope.setup({
      defaults = {
        file_ignore_patterns = {
          "node_modules/",
          "%.git/",
          "%.env/",
        }
      },
      extensions = {
        ["ui-select"] = { require("telescope.themes").get_dropdown {} }
      }
    })
    telescope.load_extension("ui-select")
  end
}
