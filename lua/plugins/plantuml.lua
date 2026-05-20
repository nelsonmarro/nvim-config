return {
  {
    "Maduki-tech/nvim-plantuml",
    ft = { "plantuml", "puml" },
    config = function()
      require("plantuml").setup({
        output_dir = "/tmp", -- Directory to store rendered diagrams
        viewer = "xdg-open", -- Command to open rendered diagrams (Arch Linux default)
        auto_refresh = true, -- Enable auto-refresh on save
      })
    end,
    keys = {
      { "<leader>pp", "<cmd>PlantUMLPreview<cr>", desc = "PlantUML Preview" },
    },
  },
}
