return {
  "williamboman/mason.nvim",
  build = ":MasonUpdate",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "neovim/nvim-lspconfig",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "gopls",
        "lua_ls",
        "pyright",
        "ts_ls",
      },
    })
    require("mason-tool-installer").setup({
      ensure_installed = {
        "goimports",
        "prettier",
        "ruff",
        "stylua",
      },
    })
  end,
}
