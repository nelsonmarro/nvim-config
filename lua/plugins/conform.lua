return {
  {
    "conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft.templ = { "templ" }
      opts.formatters_by_ft.razor = { "rzls" }
      opts.formatters.prettier = {
        -- Prepend arguments to the prettier command
        prepend_args = {
          "--trailing-comma=none",
          "--print-width=80",
        },
      }
    end,
  },
}
