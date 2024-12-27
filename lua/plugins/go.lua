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
        lsp_cfg = false, -- true: use non-default gopls setup specified in go/lsp.lua
        lsp_keymaps = true, -- set to false to disable gopls/lsp keymap
        lsp_codelens = true, -- set to false to disable codelens, true by default, you can use a function
        lsp_document_formatting = true,
        -- set to true: use gopls to format
        -- false if you want to use other formatter tool(e.g. efm, nulls)
        lsp_inlay_hints = {
          enable = true,
          -- hint style, set to 'eol' for end-of-line hints, 'inlay' for inline hints
          -- inlay only available for 0.10.x
          style = "inlay",
          -- Note: following setup only works for style = 'eol', you do not need to set it for 'inlay'
          -- Only show inlay hints for the current line
          only_current_line = false,
          -- Event which triggers a refersh of the inlay hints.
          -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
          -- not that this may cause higher CPU usage.
          -- This option is only respected when only_current_line and
          -- autoSetHints both are true.
          only_current_line_autocmd = "CursorHold",
          -- whether to show variable name before type hints with the inlay hints or not
          -- default: false
          show_variable_name = false,
          -- prefix for parameter hints
          parameter_hints_prefix = "󰊕 ",
          show_parameter_hints = true,
          -- prefix for all the other hints (type, chaining)
          other_hints_prefix = "=> ",
          -- whether to align to the length of the longest line in the file
          max_len_align = false,
          -- padding from the left if max_len_align is true
          max_len_align_padding = 1,
          -- whether to align to the extreme right or not
          right_align = false,
          -- padding from the right if right_align is true
          right_align_padding = 6,
          -- The color of the hints
          highlight = "Comment",
        },
        dap_debug = true, -- set to false to disable dap
        dap_debug_keymap = true, -- true: use keymap for debugger defined in go/dap.lua
        -- false: do not use keymap in go/dap.lua.  you must define your own.
        -- Windows: Use Visual Studio keymap
        -- to setup a table of codelens
        dap_debug_gui = {}, -- bool|table put your dap-ui setup here set to false to disable
        dap_debug_vt = { enabled_commands = true, all_frames = true }, -- bool|table put your dap-virtual-text setup here set to false to disable

        dap_port = 38697, -- can be set to a number, if set to -1 go.nvim will pick up a random port
        dap_timeout = 15, --  see dap option initialize_timeout_sec = 15,
        dap_retries = 20, -- see dap option max_retries
        build_tags = "tag1,tag2", -- set default build tags
        textobjects = true, -- enable default text objects through treesittter-text-objects
        test_runner = "go", -- one of {`go`,  `dlv`, `ginkgo`, `gotestsum`}
        verbose_tests = true, -- set to add verbose flag to tests deprecated, see '-v' option
        run_in_floaterm = false, -- set to true to run in a float window. :GoTermClose closes the floatterm
        -- float term recommend if you use gotestsum ginkgo with terminal color

        trouble = true, -- true: use trouble to open quickfix
        test_efm = false, -- errorfomat for quickfix, default mix mode, set to true will be efm only
        luasnip = false, -- enable included luasnip snippets. you can also disable while add lua/snips folder to luasnip load
        iferr_vertical_shift = 2, -- defines where the cursor will end up vertically from the begining of if err statement
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
