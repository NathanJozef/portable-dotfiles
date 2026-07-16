require("config.lazy")

vim.o.autoread = true
vim.o.signcolumn = "yes"

local function open_line_diagnostic()
  local _, winid = vim.diagnostic.open_float({ scope = "line", border = "rounded", source = true })
  if not winid then
    vim.notify("No diagnostics on current line", vim.log.levels.INFO)
  end
end

vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>', { desc = 'Find files' })
vim.keymap.set('n', '<leader>fg', ':Telescope live_grep<CR>', { desc = 'Live grep' })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', 'gl', open_line_diagnostic, { desc = 'Line diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
vim.keymap.set('n', '<leader>e', ':Neotree filesystem reveal left<CR>', { desc = 'File explorer' })
vim.keymap.set('n', '<leader>b', ':Neotree buffers reveal left<CR>', { desc = 'Buffer explorer' })
vim.keymap.set('n', '<leader>g', ':Neotree git_status left<CR>', { desc = 'Git status explorer' })
