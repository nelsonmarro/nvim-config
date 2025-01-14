return {
  {
    "Jezda1337/nvim-html-css",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("html-css"):setup()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
      "amarakon/nvim-cmp-fonts",
    },
    opts = function(_, opts)
      table.insert(opts.sources, 1, {
        name = "copilot",
        group_index = 2,
      })
      table.insert(opts.sources, { name = "emoji" })
      table.insert(opts.sources, {
        name = "html-css",
        option = {
          enable_on = {
            "html",
            "javascript",
            "typescript",
            "javascriptreact",
            "typescriptreact",
          }, -- set the file types you want the plugin to work on
          file_extensions = { "css", "sass", "less" }, -- set the local filetypes from which you want to derive classes
          style_sheets = {
            -- example of remote styles, only css no js for now
            "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css",
          },
        },
      })
      local format_kinds = opts.formatting.format
      opts.formatting.format = function(entry, item)
        if entry.source.name == "html-css" then
          item.menu = entry.completion_item.menu
        end
        format_kinds(entry, item) -- add icons
        return require("tailwindcss-colorizer-cmp").formatter(entry, item)
      end
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
