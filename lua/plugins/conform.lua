return {
  {
    "conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft.templ = { "templ" }
      opts.formatters_by_ft.razor = { "rzls" }
      opts.formatters_by_ft.sql = { "sql_formatter" }

      opts.formatters = opts.formatters or {}
      opts.formatters.prettier = {
        prepend_args = { "--single-quote" },
      }
    end,
  },
}
