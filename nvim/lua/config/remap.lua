vim.keymap.set("n", "<leader>pv", "<cmd>Ex<CR>")

--copy and pasting
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]])

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>")

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww sessionizer<CR>")
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<CR>")
