return {
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    "folke/tokyonight.nvim",
    enabled = true,
    opts = {
      style = "night",
      -- transparent = true,
      styles = {
        -- sidebars = 'transparent',
        -- floats = 'transparent',
        comments = { italic = true },
        keywords = { italic = true },
      },
      on_colors = function(colors)
        -- colors.bg_statusline = colors.none
        -- colors.border = colors.purple
        -- colors.bg_dark = colors.none
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
