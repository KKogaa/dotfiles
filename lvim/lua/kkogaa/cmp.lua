
local cmp = require("cmp")
lvim.builtin.cmp.mapping = cmp.mapping.preset.insert({
      ["<A-k>"] = cmp.mapping.select_prev_item(),
      ["<A-j>"] = cmp.mapping.select_next_item(),
      ['<A-b>'] = cmp.mapping.scroll_docs(-4),
      ['<A-f>'] = cmp.mapping.scroll_docs(4),
      ['<A-i>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<Tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
})
