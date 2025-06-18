return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      }
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
        enabled = false,
      },
      ---@type lspconfig.options
      servers = {
        eslint = {
          settings = {
            -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
            workingDirectories = { mode = "auto" },
            format = auto_format,
          },
        },
        gopls = {},
        templ = {
          filetypes = { "templ" },
        },
        html = {
          filetypes = { "html", "templ" },
        },
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
        tailwindcss = {},
        hyprls = {},
        qmlls = {
          cmd = { "qmlls6" },
          filetypes = { "qml", "qmljs" },
          root_dir = function(fname)
            return vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
          end,
          single_file_support = true,
        },
      },
      setup = {
        eslint = function()
          if not auto_format then
            return
          end

          local function get_client(buf)
            return LazyVim.lsp.get_clients({ name = "eslint", bufnr = buf })[1]
          end

          local formatter = LazyVim.lsp.formatter({
            name = "eslint: lsp",
            primary = false,
            priority = 200,
            filter = "eslint",
          })

          -- Use EslintFixAll on Neovim < 0.10.0
          if not pcall(require, "vim.lsp._dynamic") then
            formatter.name = "eslint: EslintFixAll"
            formatter.sources = function(buf)
              local client = get_client(buf)
              return client and { "eslint" } or {}
            end
            formatter.format = function(buf)
              local client = get_client(buf)
              if client then
                local diag = vim.diagnostic.get(buf, { namespace = vim.lsp.diagnostic.get_namespace(client.id) })
                if #diag > 0 then
                  vim.cmd("EslintFixAll")
                end
              end
            end
          end

          -- register the formatter with LazyVim
          LazyVim.format.register(formatter)
        end,
        clangd = function(_, opts)
          opts.on_attach = function(client, _)
            require("clangd_extensions.inlay_hints").setup_autocmd()
            require("clangd_extensions.inlay_hints").set_inlay_hints()
          end
        end,
        csharp_ls = function(_, opts)
          opts.handlers = {
            ["textDocument/definition"] = require("csharpls_extended").handler,
            ["textDocument/typeDefinition"] = require("csharpls_extended").handler,
          }
          require("csharpls_extended").buf_read_cmd_bind()
          require("telescope").load_extension("csharpls_definition")
        end,
      },
    },
  },
}
