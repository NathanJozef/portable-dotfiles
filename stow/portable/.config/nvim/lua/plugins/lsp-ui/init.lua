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
      { "<C-s>", "<cmd>Lspsaga signature_help<CR>", mode = { "n", "i" }, desc = "Signature help" },
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
