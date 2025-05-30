return {
  {
    "Decodetalkers/csharpls-extended-lsp.nvim",
    event = "LazyFile",
    lazy = true,
  },
  -- lazy.nvim
  {
    "GustavEikaas/easy-dotnet.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    config = function()
      require("easy-dotnet").setup()
    end,
  },
}
