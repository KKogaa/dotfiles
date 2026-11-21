return {
  "https://gitlab.com/schrieveslaach/sonarlint.nvim.git",
  dependencies = { "nvim-telescope/telescope.nvim", },
  lazy = true,
  ft = {
    "python",
    "java",
    "typescript",
    "javascript",
    "go",
  },
  config = function()
    require("sonarlint").setup({
      server = {
        cmd = {
          "sonarlint-language-server",
          "-stdio",
          "-analyzers",
          vim.fn.expand(vim.fn.stdpath 'data' ..
            '/mason/packages/sonarlint-language-server/extension/analyzers/sonarjava.jar'),
          vim.fn.expand(vim.fn.stdpath 'data' ..
            '/mason/packages/sonarlint-language-server/extension/analyzers/sonarpython.jar'),
          -- vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarpython.jar"),
          -- vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarcfamily.jar"),
          -- vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjava.jar"),
          -- vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjs.jar"),
          -- vim.fn.expand("$MASON/share/sonarlint-analyzers/sonargo.jar"),
        },
      },
      filetypes = {
        "python",
        "java",
        "typescript",
        "javascript",
        "go",
      },
    })
  end,
}
