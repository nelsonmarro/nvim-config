return {
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup({

        -- settings with {}; user need to setup ALL the settings
        go = "go", -- go command, can be go[default] or go1.18beta1
        goimports = "goimports", -- goimports command, can be gopls[default] or either goimports or golines if need to split long lines
        gofmt = "gofmt", -- gofmt through gopls: alternative is gofumpt, goimports, golines, gofmt, etc
        fillstruct = "gopls", -- set to fillstruct if gopls fails to fill struct
        -- max_line_len = 80, -- max line length in golines format, Target maximum line length for golines
        lsp_cfg = true, -- true: use non-default gopls setup specified in go/lsp.lua
        lsp_keymaps = true, -- set to false to disable gopls/lsp keymap
        lsp_codelens = true, -- set to false to disable codelens, true by default, you can use a function
        lsp_document_formatting = true,
        lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
        lsp_on_attach = true, -- use on_attach from go.nvim
        dap_debug = true,
        trouble = true, -- true: use trouble to open quickfix
        luasnip = true, -- enable included luasnip snippets. you can also disable while add lua/snips folder to luasnip load
        lsp_inlay_hints = {
          enable = false,
        },
        -- golangci_lint = {
        --   default = "standard", -- set to one of { 'standard', 'fast', 'all', 'none' }
        --   -- disable = {'errcheck', 'staticcheck'}, -- linters to disable empty by default
        --   -- enable = {'govet', 'ineffassign','revive', 'gosimple'}, -- linters to enable; empty by default
        --   config = nil, -- set to a config file path
        --   no_config = false, -- true: golangci-lint --no-config
        --   -- disable = {},     -- linters to disable empty by default, e.g. {'errcheck', 'staticcheck'}
        --   -- enable = {},      -- linters to enable; empty by default, set to e.g. {'govet', 'ineffassign','revive', 'gosimple'}
        --   -- enable_only = {}, -- linters to enable only; empty by default, set to e.g. {'govet', 'ineffassign','revive', 'gosimple'}
        --   severity = vim.diagnostic.severity.INFO, -- severity level of the diagnostics
        -- },
      })

      local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          require("go.format").goimports()
        end,
        group = format_sync_grp,
      })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
}
