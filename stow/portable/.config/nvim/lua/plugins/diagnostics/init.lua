return {
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  lazy = false,
  config = function()
    local lsp_lines = require("lsp_lines")

    lsp_lines.setup()

    vim.diagnostic.config({
      virtual_text = false,
      virtual_lines = true,
      underline = true,
      signs = true,
      severity_sort = true,
      float = {
        border = "rounded",
        source = true,
      },
    })

    vim.keymap.set("n", "<leader>dl", lsp_lines.toggle, { desc = "Toggle diagnostic lines" })
  end,
}
