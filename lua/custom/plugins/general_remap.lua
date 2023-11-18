vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.swapfile = false

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {desc = 'Move line down'})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {desc = 'Move line up'})

vim.keymap.set("n", "<C-d>", "<C-d>zz", {desc = 'Jump up half page and set cursor to mid'})
vim.keymap.set("n", "<C-u>", "<C-u>zz", {desc = 'Jump down half page and set cursor to mid'})

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.fn.expand('%:p')
vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>")
vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>")
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = 'Paste without replacing clipboard' })

return {}
