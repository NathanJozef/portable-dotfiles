require("config.lazy")

vim.o.autoread = true
vim.o.signcolumn = "yes"

vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>')
vim.keymap.set('n', '<leader>fg', ':Telescope live_grep<CR>')
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
