return {
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    config = function(_, opts)
      opts.modes = {
        diagnostics = {
          filter = function(items)
            return vim.tbl_filter(function(item)
              return not string.match(item.basename, [[%__virtual.cs$]])
            end, items)
          end,
        },
      }
    end,
  },
}
