require("config.lazy")

vim.o.autoread = true
vim.o.signcolumn = "yes"

vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>', { desc = 'Find files' })
vim.keymap.set('n', '<leader>fg', ':Telescope live_grep<CR>', { desc = 'Live grep' })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', '<leader>e', ':Neotree filesystem reveal left<CR>', { desc = 'File explorer' })
vim.keymap.set('n', '<leader>b', ':Neotree buffers reveal left<CR>', { desc = 'Buffer explorer' })
vim.keymap.set('n', '<leader>g', ':Neotree git_status left<CR>', { desc = 'Git status explorer' })
