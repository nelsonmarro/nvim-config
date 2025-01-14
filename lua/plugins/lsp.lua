return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "luacheck",
        "shellcheck",
        "shfmt",
        "tailwindcss-language-server",
        "css-lsp",
        "gopls",
        "vtsls",
        "html-lsp",
        "prettier",
      })
    end,
  },
  -- lsp servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      codelens = {
        enabled = true,
      },
      ---@type lspconfig.options
      servers = {
        templ = {},
        html = {},
        htmx = {},
        emmet_language_server = {
          cmd = { "emmet-language-server", "--stdio" },
          filetypes = {
            "css",
            "eruby",
            "html",
            "htmldjango",
            "javascriptreact",
            "less",
            "pug",
            "sass",
            "scss",
            "typescriptreact",
            "htmlangular",
            "templ",
          },
        },
        tailwindcss = {
          settings = {
            tailwindCSS = {
              includeLanguages = {
                templ = "html",
              },
            },
          },
        },
        qmlls = {
          cmd = { "qmlls6" },
          filetypes = { "qml", "qmljs" },
          root_dir = function(fname)
            return vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
          end,
          single_file_support = true,
        },
        omnisharp = {
          enabled = false,
        },
        csharp_ls = {},
      },
      setup = {
        omnisharp = function()
          -- disable tsserver
          return true
        end,
        clangd = function(_, opts)
          opts.on_attach = function(client, _)
            require("clangd_extensions.inlay_hints").setup_autocmd()
            require("clangd_extensions.inlay_hints").set_inlay_hints()
          end
        end,
      },
    },
    config = function(_, opts)
      local lspconfig = require("lspconfig")
      for server, config in pairs(opts.servers) do
        -- passing config.capabilities to blink.cmp merges with the capabilities in your
        -- `opts[server].capabilities, if you've defined it
        config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end
    end,
  },
}
