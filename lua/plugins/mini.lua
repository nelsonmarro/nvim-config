return {
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      require("mini.icons").setup({})
      require("mini.ai").setup({})
      require("mini.surround").setup({})
    end,
  },
}
