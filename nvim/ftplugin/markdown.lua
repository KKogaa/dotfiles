-- Prose reads better wrapped to the window (and so the tmux pane) width.
-- vim.opt_local keeps this to markdown buffers; code stays unwrapped (set.lua).
vim.opt_local.wrap = true
vim.opt_local.linebreak = true -- break at word boundaries, not mid-word
vim.opt_local.breakindent = true -- wrapped lines keep the indent of lists and quotes
vim.opt_local.colorcolumn = ""

-- Move by screen line on wrapped text; a count (5j) still moves by real lines.
vim.keymap.set({ "n", "x" }, "j", "v:count ? 'j' : 'gj'", { buffer = true, expr = true })
vim.keymap.set({ "n", "x" }, "k", "v:count ? 'k' : 'gk'", { buffer = true, expr = true })
