return {
  "lewis6991/gitsigns.nvim",
  lazy = false,
  config = true,
  keys = {
    { "<leader>gj", "<cmd>Gitsigns nav_hunk next<CR>" },
    { "<leader>gk", "<cmd>Gitsigns nav_hunk prev<CR>" },
    { "<leader>gn", "<cmd>Gitsigns nav_hunk next<CR>" },
    { "]h", "<cmd>Gitsigns nav_hunk next<CR>" },
    { "[h", "<cmd>Gitsigns nav_hunk prev<CR>" },
    { "<leader>gv", "<cmd>Gitsigns preview_hunk_inline<CR>" },
    { "<leader>gt", "<cmd>Gitsigns toggle_current_line_blame<CR>" },
    { "<leader>ga", "<cmd>Gitsigns stage_hunk<CR>", mode = { "n", "v" } },
    { "<leader>gu", "<cmd>Gitsigns reset_hunk<CR>", mode = { "n", "v" } },
    { "<leader>gx", "<cmd>Gitsigns reset_buffer<CR>" },
    { "<leader>gw", "<cmd>Gitsigns toggle_word_diff<CR>" },
    { "<leader>gq", "<cmd>Gitsigns setqflist all<CR>" },
  }
}
