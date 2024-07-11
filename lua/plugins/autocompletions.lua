return {
  {
    'Jezda1337/nvim-html-css',
    event = { 'LazyFile', 'VeryLazy' },
    lazy = vim.fn.argc(-1) == 0,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('html-css'):setup()
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-emoji', 'amarakon/nvim-cmp-fonts', { 'roobert/tailwindcss-colorizer-cmp.nvim', opts = {} } },
    opts = function(_, opts)
      table.insert(opts.sources, { name = 'emoji' })
      table.insert(opts.sources, {
        name = 'html-css',
        option = {
          enable_on = {
            'html',
            'javascript',
            'typescript',
            'javascriptreact',
            'typescriptreact',
          }, -- set the file types you want the plugin to work on
          file_extensions = { 'css', 'sass', 'less' }, -- set the local filetypes from which you want to derive classes
          style_sheets = {
            -- example of remote styles, only css no js for now
            'https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css',
          },
        },
      })
      local format_kinds = opts.formatting.format
      opts.formatting.format = function(entry, item)
        if entry.source.name == 'html-css' then
          item.menu = entry.completion_item.menu
        end
        format_kinds(entry, item) -- add icons
        return require('tailwindcss-colorizer-cmp').formatter(entry, item)
      end
      vim.api.nvim_create_autocmd({ 'FileType' }, {
        pattern = { 'conf', 'config', 'bash' },
        callback = function()
          local cmp = require 'cmp'
          cmp.setup.filetype({ 'conf', 'config', 'bash' }, { sources = { { name = 'fonts' } } })
        end,
      })
    end,
  },
  config = function()
    local cmp = require 'cmp'
    cmp.setup.filetype({ 'conf', 'config' }, { sources = { { name = 'fonts' } } })
  end,

  {
    'nelsonmarro/next.js-snippets',
    branch = 'dev',
    -- config = function()
    --   require('luasnip.loaders.from_vscode').lazy_load '~/.local/share/nvim/lazy/next.js-snippets'
    -- end,
  },
  {
    'johnpapa/vscode-angular-snippets',
    -- config = function()
    --   require('luasnip.loaders.from_vscode').lazy_load '~/.local/share/nvim/lazy/vscode-angular-snippets'
    -- end,
  },
}
