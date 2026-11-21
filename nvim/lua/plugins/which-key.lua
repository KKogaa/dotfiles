-- Shows the keys that can follow a prefix (e.g. press <leader> and wait).
-- :checkhealth which-key reports overlapping and duplicate mappings.
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {},
  keys = {
    { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer keymaps" },
  },
}
