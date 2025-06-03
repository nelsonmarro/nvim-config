-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "conf", "config", "kitty" },
  callback = function()
    require("cmp").setup.filetype({ "conf", "config", "kitty" }, { sources = { { name = "fonts" } } })
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "go" },
  callback = function()
    vim.keymap.set("n", "<leader>cge", "<cmd>GoIfErr<CR>", { desc = "Add err check" })
    vim.keymap.set("n", "<leader>cgl", "<cmd>GoLint<CR>", { desc = "Lint go project" })
    vim.keymap.set("n", "<leader>cgc", '<cmd>:lua require("go.comment").gen()<CR>', { desc = "Comment go" })
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "markdown" },
  callback = function()
    vim.opt.colorcolumn = "80"
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = false
  end,
})

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "nightfox",
  callback = function()
    if vim.o.background == "light" then
      vim.fn.system("kitty +kitten themes Dayfox")
      LazyVim.config.colorscheme = "dayfox"
    elseif vim.o.background == "dark" then
      vim.fn.system("kitty +kitten themes Carbonfox")
      LazyVim.config.colorscheme = "carbonfox"
    else
      vim.fn.system("kitty +kitten themes Carbonfox")
      vim.cmd("colorscheme carbonfox")
    end
  end,
})

vim.cmd("autocmd BufEnter * set formatoptions-=cro")
vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro")
