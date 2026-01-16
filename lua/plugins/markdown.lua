return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    config = function()
      require("obsidian").get_client().opts.ui.enable = false
      vim.api.nvim_buf_clear_namespace(0, vim.api.nvim_get_namespaces()["ObsidianUI"], 0, -1)
      require("render-markdown").setup({})
    end,
  },
  {
    "selimacerbas/mermaid-playground.nvim",
    dependencies = { "barrett-ruth/live-server.nvim" },
    config = function()
      require("mermaid_playground").setup({
        -- all optional; sane defaults shown
        workspace_dir = nil, -- defaults to: $XDG_CONFIG_HOME/mermaid-playground
        index_name = "index.html",
        diagram_name = "diagram.mmd",
        overwrite_index_on_start = false, -- don't clobber your customized index.html
        auto_refresh = true,
        auto_refresh_events = { "InsertLeave", "TextChanged", "TextChangedI", "BufWritePost" },
        debounce_ms = 450,
        notify_on_refresh = false,
      })
    end,
  },
}
