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

-- vim.api.nvim_create_autocmd({ "FileType" }, {
--   pattern = { "markdown" },
--   callback = function()
--     vim.opt.colorcolumn = "80"
--   end,
-- })

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = false
  end,
})

-- Terminales que hospedan un CLI de IA (Claude Code, sidekick, opencode, ...).
-- Estas necesitan recibir <Esc> tal cual: si Neovim lo intercepta para salir a
-- modo normal, el Esc nunca llega al agente y parece que "se pierde el foco".
local ai_cmd_patterns = { "claude", "opencode", "codex", "gemini", "aider", "copilot", "cursor%-agent", "amp", "crush" }

local function looks_like_ai(value)
  if type(value) == "table" then
    value = table.concat(value, " ")
  end
  value = tostring(value or ""):lower()
  for _, pat in ipairs(ai_cmd_patterns) do
    if value:find(pat) then
      return true
    end
  end
  return false
end

-- Se evalua en el momento de pulsar la tecla, no al abrir la terminal, para no
-- depender del orden en que cada plugin marca su buffer.
function _G.is_ai_terminal(buf)
  buf = (buf == nil or buf == 0) and vim.api.nvim_get_current_buf() or buf
  -- override manual:  :AiTerm  (o :lua vim.b.ai_terminal = false)
  if vim.b[buf].ai_terminal ~= nil then
    return vim.b[buf].ai_terminal
  end
  if vim.bo[buf].filetype == "sidekick_terminal" or vim.b[buf].sidekick_cli ~= nil then
    return true
  end
  local snacks = vim.b[buf].snacks_terminal
  if type(snacks) == "table" and looks_like_ai(snacks.cmd) then
    return true
  end
  return looks_like_ai(vim.api.nvim_buf_get_name(buf))
end

function _G.set_terminal_keymaps()
  local buf = vim.api.nvim_get_current_buf()
  local opts = { buffer = buf }

  -- En una terminal de IA <Esc> se envia literal al programa; en el resto sigue
  -- saliendo a modo normal como siempre.
  vim.keymap.set("t", "<esc>", function()
    return _G.is_ai_terminal(0) and "<Esc>" or [[<C-\><C-n>]]
  end, { buffer = buf, expr = true, desc = "Esc (literal en terminales de IA)" })

  -- Salida a modo normal que SIEMPRE funciona, tambien dentro de Claude Code.
  -- <C-q> es el mismo atajo que ya usa sidekick.nvim para `stopinsert`.
  vim.keymap.set("t", "<C-q>", [[<C-\><C-n>]], { buffer = buf, desc = "Salir del modo terminal" })

  -- `jk` obliga a esperar `timeoutlen` en cada `j` que escribes, asi que solo se
  -- activa en terminales normales, nunca en el prompt de un agente.
  vim.schedule(function()
    if vim.api.nvim_buf_is_valid(buf) and not _G.is_ai_terminal(buf) then
      vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
    end
  end)

  vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

-- Marca/desmarca a mano una terminal como "de IA" (util si lanzaste `claude`
-- desde una shell ya abierta, donde el nombre del buffer no lo delata).
vim.api.nvim_create_user_command("AiTerm", function()
  local buf = vim.api.nvim_get_current_buf()
  vim.b[buf].ai_terminal = not _G.is_ai_terminal(buf)
  vim.notify("ai_terminal = " .. tostring(vim.b[buf].ai_terminal))
end, { desc = "Alternar paso literal de <Esc> en esta terminal" })

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.api.nvim_create_autocmd("TermOpen", {
  group = augroup("terminal_keymaps"),
  pattern = "*",
  callback = _G.set_terminal_keymaps,
})

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
