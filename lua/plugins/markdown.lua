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
    build = function()
      require("lazy").load({ plugins = { "markdown-preview.nvim" } })
      vim.fn["mkdp#util#install"]()
    end,
    keys = {
      {
        "<leader>cp",
        ft = "markdown",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Markdown Preview",
      },
    },
    -- ✅ AÑADIDO: Bloque init para inyectar la configuración antes de la carga
    init = function()
      -- 1. Forzar uso de Mermaid v11 desde CDN (Habilita Hand-Drawn y nuevas features)
      vim.g.mkdp_mermaid = {
        link = "https://cdn.jsdelivr.net/npm/mermaid@11.12.2/dist/mermaid.min.js",
      }
      -- 2. Asegurar detección de tipos
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    config = function()
      vim.cmd([[do FileType]])
    end,
  },
}
