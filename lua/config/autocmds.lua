-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Listen to LSP Attach
-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function(args)
--     local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
--     vim.api.nvim_create_autocmd("BufWritePre", {
--       group = augroup,
--       buffer = args.buf,
--       callback = function()
--         -- Format the code before you run fix usings
--         vim.lsp.buf.format({ timeout = 1000, async = false })
--
--         -- If the file is C# then run fix usings
--         if vim.bo[0].filetype == "cs" then
--           require("csharp").fix_usings()
--         end
--       end,
--     })
--   end,
-- })

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "cs" },
  callback = function()
    vim.b.autoformat = false
  end,
})
