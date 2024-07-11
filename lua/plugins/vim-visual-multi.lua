return {
  'mg979/vim-visual-multi',
  branch = 'master',
  lazy = false,
  cond = function()
    return not vim.g.vscode
  end,
}
