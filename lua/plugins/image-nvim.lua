return {
  {
    "3rd/image.nvim",
    build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
    opts = {
      processor = "magick_cli",
    },
  },
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {
      -- add options here
      -- or leave it empty to use the default settings
    },
    keys = {
      -- suggested keymap
      { "<leader>ip", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
      {
        "<leader>iop",
        function()
          local oil = require("oil")
          local filename = oil.get_cursor_entry().name
          local dir = oil.get_current_dir()
          oil.close()

          local img_clip = require("img-clip")
          img_clip.paste_image({}, dir .. filename)
        end,
        desc = "Paste image with oil",
      },
    },
  },
}
