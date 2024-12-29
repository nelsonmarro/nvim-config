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

        disable_defaults = false, -- true|false when true set false to all boolean settings and replace all tables
        -- settings with {}; user need to setup ALL the settings
        go = "go", -- go command, can be go[default] or go1.18beta1
        goimports = "goimports", -- goimports command, can be gopls[default] or either goimports or golines if need to split long lines
        gofmt = "golines", -- gofmt through gopls: alternative is gofumpt, goimports, golines, gofmt, etc
        fillstruct = "gopls", -- set to fillstruct if gopls fails to fill struct
        max_line_len = 80, -- max line length in golines format, Target maximum line length for golines
        lsp_cfg = true, -- true: use non-default gopls setup specified in go/lsp.lua
        lsp_keymaps = true, -- set to false to disable gopls/lsp keymap
        lsp_codelens = true, -- set to false to disable codelens, true by default, you can use a function
        lsp_document_formatting = true,
        lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
        lsp_on_attach = true, -- use on_attach from go.nvim
        dap_debug = true,
        trouble = true, -- true: use trouble to open quickfix
        luasnip = true, -- enable included luasnip snippets. you can also disable while add lua/snips folder to luasnip load
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
