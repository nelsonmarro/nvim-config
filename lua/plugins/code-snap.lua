return {
  {
    "mistricky/codesnap.nvim",
    build = "make",
    keys = {
      { "<leader>co", "<cmd>CodeSnap<cr>", mode = "x", desc = "Save selected code snapshot into clipboard" },
      { "<leader>ci", "<cmd>CodeSnapSave<cr>", mode = "x", desc = "Save selected code snapshot in ~/Pictures" },
    },
    opts = {
      save_path = "~/Pictures/Code/",
      has_breadcrumbs = true,
      bg_theme = "bamboo",
    },
  },
}
