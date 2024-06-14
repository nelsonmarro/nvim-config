return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-emoji' },
    opts = function(_, opts)
      table.insert(opts.sources, { name = 'emoji' })
    end,
  },
  {
    'nelsonmarro/next.js-snippets',
    branch = 'dev',
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load '~/.local/share/nvim/lazy/next.js-snippets'
    end,
  },
}
