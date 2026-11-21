return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  keys = {
    {
      "<leader>gd",
      function()
        if next(require("diffview.lib").views) == nil then
          vim.cmd("DiffviewOpen")
        else
          vim.cmd("DiffviewClose")
        end
      end,
      desc = "Diffview toggle (uncommitted changes)",
    },
    {
      "<leader>gm",
      function()
        -- everything on this branch, committed or not, since it forked from the PR target branch
        for _, target in ipairs({ "origin/develop", "develop", "origin/HEAD" }) do
          local base = vim.trim(vim.fn.system({ "git", "merge-base", target, "HEAD" }))
          if vim.v.shell_error == 0 then
            vim.notify("Reviewing changes against " .. target)
            vim.cmd("DiffviewOpen " .. base)
            return
          end
        end
        vim.notify("No develop or origin/HEAD branch to compare against", vim.log.levels.WARN)
      end,
      desc = "Diffview branch vs develop",
    },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "File history" },
    { "<leader>gl", "<cmd>DiffviewFileHistory<CR>", desc = "Branch history" },
  },
  opts = function()
    local actions = require("diffview.actions")
    -- shift-free file navigation and closing inside any diffview buffer
    local nav = {
      { "n", "<leader>j", actions.select_next_entry, { desc = "Next file" } },
      { "n", "<leader>k", actions.select_prev_entry, { desc = "Previous file" } },
      { "n", "q", "<cmd>DiffviewClose<CR>", { desc = "Close diffview" } },
    }
    return {
      enhanced_diff_hl = true,
      keymaps = {
        view = nav,
        file_panel = nav,
        file_history_panel = nav,
      },
      view = {
        merge_tool = { layout = "diff3_mixed" },
      },
      hooks = {
        -- refresh the file panel when Claude touches files while the view is open
        view_enter = function() vim.cmd("DiffviewRefresh") end,
      },
    }
  end,
}
