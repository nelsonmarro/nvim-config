return {
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        'luacheck',
        'shellcheck',
        'shfmt',
        'tailwindcss-language-server',
        'css-lsp',
        'gopls',
        'vtsls',
        'html-lsp',
        'prettier',
      })
    end,
  },
  -- lsp servers
  {
    'neovim/nvim-lspconfig',
    opts = {
      inlay_hints = { enabled = false },
      codelens = {
        enabled = false,
      },
      ---@type lspconfig.options
      servers = {
        gopls = {
          settings = {
            gopls = {
              gofumpt = true,
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              analyses = {
                fieldalignment = true,
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
              directoryFilters = { '-.git', '-.vscode', '-.idea', '-.vscode-test', '-node_modules' },
              semanticTokens = true,
            },
          },
        },
        omnisharp = {
          enabled = false,
        },
        csharp_ls = {},
        angularls = {
          root_dir = require('lspconfig.util').root_pattern 'angular.json',
        },
      },
      setup = {
        angularls = function(_, opts)
          -- local cmd = {
          --   'ngserver',
          --   '--stdio',
          --   '--tsProbeLocations',
          --   table.concat({
          --     '/home/nelson/.config/nvm/versions/node/v20.15.0/lib/node_modules/@angular/language-service',
          --   }, ','),
          --   '--ngProbeLocations',
          --   table.concat({
          --     '/home/nelson/.config/nvm/versions/node/v20.15.0/lib/node_modules/@angular/language-service',
          --   }, ','),
          -- }
          --
          -- opts.cmd = cmd
          -- opts.on_new_config = function(new_config, new_root_dir)
          --   new_config.cmd = cmd
          -- end

          LazyVim.lsp.on_attach(function(client)
            --HACK: disable angular renaming capability due to duplicate rename popping up
            client.server_capabilities.renameProvider = false
          end, 'angularls')
        end,
        gopls = function(_, opts)
          LazyVim.lsp.on_attach(function(client, _)
            if not client.server_capabilities.semanticTokensProvider then
              local semantic = client.config.capabilities.textDocument.semanticTokens
              client.server_capabilities.semanticTokensProvider = {
                full = true,
                legend = {
                  tokenTypes = semantic.tokenTypes,
                  tokenModifiers = semantic.tokenModifiers,
                },
                range = true,
              }
            end
          end, 'gopls')
          -- end workaround
        end,
        omnisharp = function()
          -- disable tsserver
          return true
        end,
      },
    },
  },
}
