return {
  {
    "tzachar/cmp-tabnine",
    dependencies = {
      {
        "hrsh7th/nvim-cmp",
        optional = true,
        dependencies = { "tzachar/cmp-tabnine" },
        ---@param opts cmp.ConfigSchema
        opts = function(_, opts)
          table.insert(opts.sources, 1, {
            name = "cmp_tabnine",
            group_index = 1,
            priority = 100,
          })

          opts.formatting.format = LazyVim.inject.args(opts.formatting.format, function(entry, item)
            -- Hide percentage in the menu
            if entry.source.name == "cmp_tabnine" then
              item.menu = ""
            end
          end)
        end,
      },
    },
    build = LazyVim.is_win() and "pwsh -noni .\\install.ps1" or "./install.sh",
    opts = {
      max_lines = 1000,
      max_num_results = 3,
      sort = true,
    },
    config = function(_, opts)
      require("cmp_tabnine.config"):setup(opts)
    end,
  },

  {
    "saghen/blink.cmp",
    optional = true,
    dependencies = { "tzachar/cmp-tabnine", "saghen/blink.compat" },
    opts = {
      sources = {
        compat = { "cmp_tabnine" },
        providers = {
          cmp_tabnine = {
            kind = "TabNine",
            score_offset = 100,
            async = true,
          },
        },
      },
    },
  },
}
