return {
  {
    "conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft.templ = { "templ" }
    end,
  },
}
