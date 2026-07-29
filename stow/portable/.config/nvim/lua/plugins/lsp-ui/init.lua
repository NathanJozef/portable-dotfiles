return {
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "K", "<cmd>Lspsaga hover_doc<CR>", desc = "Hover docs" },
      { "<C-s>", vim.lsp.buf.signature_help, mode = { "n", "i" }, desc = "Signature help" },
    },
    opts = {
      ui = {
        border = "rounded",
      },
      lightbulb = {
        enable = false,
      },
      symbol_in_winbar = {
        enable = false,
      },
    },
  },
}
