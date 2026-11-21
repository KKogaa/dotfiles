return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" },
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  build = function()
    -- The renderer needs both parsers; on-demand install only fetches "markdown".
    require("nvim-treesitter").install({ "markdown", "markdown_inline" })
  end,
  keys = {
    { "<leader>md", "<cmd>RenderMarkdown toggle<cr>", ft = "markdown", desc = "Toggle markdown rendering" },
  },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {},
}
