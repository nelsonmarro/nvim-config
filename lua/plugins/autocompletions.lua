return {
  {
    "Jezda1337/nvim-html-css",
    config = function()
      require("html-css"):setup()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
      "amarz45/nvim-cmp-fonts",
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      opts.experimental = opts.experimental or {}
      opts.experimental.ghost_text = {
        hl_group = "LspCodeLens",
      }

      opts.mapping = vim.tbl_extend("force", opts.mapping or {}, {
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif package.loaded["sidekick"] and require("sidekick").nes_jump_or_apply() then
            -- handled by sidekick
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
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
            "razor",
            "cshtml",
            "templ",
          }, -- set the file types you want the plugin to work on
          file_extensions = { "css", "sass", "less" }, -- set the local filetypes from which you want to derive classes
          style_sheets = {
            -- example of remote styles, only css no js for now
            "https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css",
            -- "https://cdn.jsdelivr.net/npm/@ionic/core/css/ionic.bundle.css",
          },
        },
      })
      local format_kinds = opts.formatting.format
      opts.formatting.format = function(entry, item)
        local source = entry.source.name
        if source == "html-css" then
          item.menu = "[" .. (entry.completion_item.provider .. "]" or "[html-css]")
        end
        local color_item = require("nvim-highlight-colors").format(entry, { kind = item.kind })
        if color_item.abbr_hl_group then
          item.kind_hl_group = color_item.abbr_hl_group
          item.kind = color_item.abbr
        end
        format_kinds(entry, item)
        return require("tailwindcss-colorizer-cmp").formatter(entry, item)
      end
    end,
  },

  -- -- Snippets
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
        "dsznajder/vscode-es7-javascript-react-snippets",
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
          "~/.local/share/nvim/lazy/vscode-es7-javascript-react-snippets",
        },
      })
    end,
  },
}
