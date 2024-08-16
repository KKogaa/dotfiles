return {
  'stevearc/conform.nvim',
  dependencies = { "williamboman/mason.nvim" },
  lazy = true,
  cmd = "ConformInfo",
	 keys = {
		{
			"<leader>cf",
			function()
				require("conform").format()
			end,
			desc = "Format",
		},
	},
  opts = {
    default_format_opts = {
          timeout_ms = 3000,
          async = false,
          quiet = false,
          lsp_format = "fallback",
        },
    formatters_by_ft = {
      typescript = { "prettier" },
      javascript = { "prettier" },
      python = { "black" },
      Go = { "gofumpt" },
      lua = { "stylua" },
      rust = { "rustfmt" },
    }
  },
  config = true,
}
