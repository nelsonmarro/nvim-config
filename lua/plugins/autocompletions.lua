return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
      "amarz45/nvim-cmp-fonts",
      "Jezda1337/nvim-html-css",
    },
    opts = {
      sources = {
        {
          name = "html-css",
          option = {
            enable_on = { "html", "templ", "javascript", "typescript", "javascriptreact", "typescriptreact" }, -- html is enabled by default
            notify = false,
            documentation = {
              auto_show = true, -- show documentation on select
            },
            -- add any external scss like one below
            style_sheets = {
              "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css",
              "https://cdn.jsdelivr.net/npm/@ionic/core/css/ionic.bundle.css",
            },
          },
        },
        {
          name = "emoji",
        },
      },
    },
  },

  -- Snippets
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    build = (not LazyVim.is_win())
        and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
      or nil,
    dependencies = {
      {
        "Nash0x7E2/awesome-flutter-snippets",
        "rafamadriz/friendly-snippets",
        "johnpapa/vscode-angular-snippets",
        {
          "nelsonmarro/next.js-snippets",
          branch = "dev",
        },
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
          require("luasnip.loaders.from_vscode").lazy_load({
            paths = {
              vim.fn.stdpath("config") .. "/snippets",
            },
          })
        end,
      },
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = {
          "~/.local/share/nvim/lazy/awesome-flutter-snippets",
          "~/.local/share/nvim/lazy/next.js-snippets",
          "~/.local/share/nvim/lazy/vscode-angular-snippets",
        },
      })
    end,
  },
}
