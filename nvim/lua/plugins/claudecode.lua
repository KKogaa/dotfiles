-- Claude Code runs in its own terminal; run `/ide` there to connect to this nvim
return {
  "coder/claudecode.nvim",
  lazy = false,
  opts = {
    terminal = { provider = "none" },
    diff_opts = { open_in_new_tab = true },
  },
  keys = {
    { "<leader>is", "<cmd>ClaudeCodeSend<CR>", mode = "v", desc = "Send selection to Claude" },
    { "<leader>ib", "<cmd>ClaudeCodeAdd %<CR>", desc = "Add buffer to Claude context" },
    { "<leader>iy", "<cmd>ClaudeCodeDiffAccept<CR>", desc = "Accept Claude diff" },
    { "<leader>in", "<cmd>ClaudeCodeDiffDeny<CR>", desc = "Deny Claude diff" },
    { "<leader>iq", "<cmd>ClaudeCodeCloseAllDiffs<CR>", desc = "Close all Claude diffs" },
  },
}
