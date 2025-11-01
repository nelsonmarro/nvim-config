return {
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim", "stevearc/dressing.nvim" },
    opts = {
      debugger = {
        enabled = true,
        run_via_dap = true,
        register_configurations = function(_)
          require("dap").adapters.dart = {
            type = "executable",
            command = "/home/nelson/.local/share/nvim/mason/bin/dart-debug-adapter",
            args = { "flutter" },
          }

          -- require("dap").adapters.flutter = {
          --   type = "executable",
          --     command = vim.fn.stdpath('data')..'/mason/bin/dart-debug-adapter',
          --   args = {"flutter"}
          -- }

          require("dap").configurations.dart = {
            {
              type = "dart",
              request = "launch",
              name = "Launch flutter",
              dartSdkPath = "/opt/dart-sdk",
              flutterSdkPath = "/usr/lib/flutter",
              program = "${workspaceFolder}/lib/main.dart",
              cwd = "${workspaceFolder}",
            },
          }

          -- require("dap.ext.vscode").load_launchjs()
        end,
      },
      lsp = {
        on_attach = require("snacks.util").lsp.on_attach,
        color = {
          enabled = true,
        },
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
          renameFilesWithClasses = "prompt",
          enableSnippets = true,
          enableSdkFormatter = true,
          analysisExcludedFolders = {
            ".dart_tool",
          },
        },
        -- capabilities = require("cmp_nvim_lsp").default_capabilities(),
      },
    },
  },
}
