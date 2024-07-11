return {
  {
    'vhyrro/luarocks.nvim',
    priority = 1000,
    config = true,
    opts = {
      rocks = { 'lua-curl', 'nvim-nio', 'mimetypes', 'xml2lua' },
    },
  },
  {
    'rest-nvim/rest.nvim',
    ft = 'http',
    dependencies = { 'luarocks.nvim' },

    config = function()
      require('rest-nvim').setup()
      vim.keymap.set('n', '<leader>rr', '<cmd>Rest run<cr>', { desc = 'Run request under the cursor' })
      vim.keymap.set('n', '<leader>rl', '<cmd>Rest run last<cr>', { desc = 'Re-run latest request' })
    end,
  },
}
