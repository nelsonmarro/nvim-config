return {
  {
    "mason-org/mason.nvim",
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
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local auto_format = true
      return {
        inlay_hints = { enabled = false },
        codelens = {
          enabled = false,
        },
        ---@type lspconfig.options
        servers = {
          copilot = { enabled = false },
        sqls = {},
        gdscript = {},
        gdshader_lsp = {},
        pyright = {
          settings = {
            python = {
              pythonPath = "./.venv/bin/python",
              analysis = {
                useLibraryCodeForTypes = true,
              },
            },
          },
        },
        eslint = {
          settings = {
            -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
            workingDirectories = { mode = "auto" },
            format = auto_format,
          },
        },
        gopls = {
          settings = {
            gopls = {
              buildFlags = { "-tags=integration" },
            },
          },
        },
        templ = {
          filetypes = { "templ" },
        },
        vtsls = {
          settings = {
            typescript = {
              preferences = {
                quoteStyle = "single",
                includeCompletionsForModuleExports = true,
                includeCompletionsForImportStatements = true,
              },
            },
            javascript = {
              preferences = {
                quoteStyle = "single",
                includeCompletionsForModuleExports = true,
                includeCompletionsForImportStatements = true,
              },
            },
            vtsls = {
              autoUseWorkspaceTsdk = true,
              experimental = {
                completion = {
                  enableServerSideFuzzyMatch = true,
                },
              },
            },
          },
        },
        html = {
          filetypes = { "html", "templ", "razor", "cshtml" },
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
            "razor",
            "cshtml",
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
        omnisharp = {
          enabled = false,
        },
        sqlfluff = {
          enabled = false,
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
        omnisharp = function()
          -- disable tsserver
          return true
        end,
        sqlfluff = function()
          -- disable tsserver
          return true
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
