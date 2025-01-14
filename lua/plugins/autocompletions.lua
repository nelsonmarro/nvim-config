return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "Jezda1337/nvim-html-css", -- add it as dependencies of `nvim-cmp` or standalone plugin
    },
    opts = {
      sources = {
        {
          name = "html-css",
          option = {
            enable_on = {
              "html",
              "templ",
              "javascript",
              "typescript",
              "javascriptreact",
              "typescriptreact",
            }, -- html is enabled by default
            notify = false,
            documentation = {
              auto_show = true, -- show documentation on select
            },
            -- add any external scss like one below
            style_sheets = {
              "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css",
            },
          },
        },
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
      "amarakon/nvim-cmp-fonts",
    },
    opts = function(_, opts)
      vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = { "conf", "config", "bash" },
        callback = function()
          local cmp = require("cmp")
          cmp.setup.filetype({ "conf", "config", "bash" }, { sources = { { name = "fonts" } } })
        end,
      })
    end,
  },

  -- Snippets
  {
    "garymjr/nvim-snippets",
    opts = {
      friendly_snippets = true,
      search_paths = {
        "~/.local/share/nvim/lazy/next.js-snippets",
        -- '~/.local/share/nvim/lazy/vscode-angular-snippets',
      },
    },
    dependencies = {
      "rafamadriz/friendly-snippets",
      "johnpapa/vscode-angular-snippets",
      {
        "nelsonmarro/next.js-snippets",
        branch = "dev",
      },
    },
  },
}
