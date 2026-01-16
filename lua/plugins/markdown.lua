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
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }

      -- ESTA ES LA CLAVE: Forzar la versión 11 vía CDN
      vim.g.mkdp_mermaid = {
        link = "https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.min.js",
      }
    end,
    ft = { "markdown" },
  },
}
