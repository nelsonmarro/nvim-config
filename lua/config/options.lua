-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
vim.opt.swapfile = false
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false
vim.opt.wildignore:append '*/node_modules/*'
vim.opt.splitkeep = 'cursor'
-- vim.opt.termguicolors = true
vim.opt.hlsearch = true
vim.opt.clipboard = 'unnamedplus'

-- vim: ts=2 sts=2 sw=2 et
