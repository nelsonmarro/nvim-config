-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
local keymap = vim.keymap

keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
keymap.set('n', 'x', '"_x')

-- Select All
keymap.set('n', '<M-y>', 'ggVG', { desc = 'Select All' })

-- paste without overwriting
keymap.set('v', 'p', 'P')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
-- keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

keymap.set('n', '<leader>th', "<Cmd>exe v:count1 . 'ToggleTerm direction=horizontal'<CR>", { desc = 'Toggle Terminal Horizontal' })
keymap.set('n', '<leader>tv', "<Cmd>exe v:count1 . 'ToggleTerm direction=vertical size=70'<CR>", { desc = 'Toggle Terminal Vertical' })

keymap.set('n', '<leader>tr', "<Cmd>exe v:count1 . 'ToggleTermSetName'<CR>", { desc = 'Set Name To Terminal' })
keymap.set('n', '<leader>ta', '<Cmd>ToggleTermToggleAll<CR>', { desc = 'Toggle All Terminals' })
keymap.set('n', '<leader>ts', '<Cmd>TermSelect<CR>', { desc = 'Select Terminal' })

-- noice
keymap.set('c', '<S-Enter>', function()
  require('noice').redirect(fn.getcmdline())
end, { desc = 'Redirect Cmdline' })

keymap.set({ 'n', 'i', 's' }, '<c-f>', function()
  if not require('noice.lsp').scroll(4) then
    return '<c-f>'
  end
end, { silent = true, expr = true })

keymap.set({ 'n', 'i', 's' }, '<c-b>', function()
  if not require('noice.lsp').scroll(-4) then
    return '<c-b>'
  end
end, { silent = true, expr = true })
-- telescope
vim.api.nvim_set_keymap('n', '<Leader>ff', '<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files,-u<CR>', { noremap = true, silent = true })

if vim.g.vscode then
  keymap.set('n', '<leader>c', '<Cmd>e ~/.config/nvim/lua/config/keymaps.lua<CR>')
  vim.keymap.set({ 'n', 'x', 'i' }, '<C-d>', function()
    require('vscode-multi-cursor').addSelectionToNextFindMatch()
  end)
end
