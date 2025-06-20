return {
  {
    "conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft.templ = { "templ" }
      opts.formatters_by_ft.razor = { "rzls" }
    end,
  },
}
