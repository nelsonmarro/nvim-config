return {
  "Funk66/jira.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cond = function()
    return vim.env.JIRA_API_TOKEN ~= nil
  end,
  opts = {},
  keys = {
    { "<leader>jv", ":JiraView<cr>", desc = "View Jira issue", silent = true },
    { "<leader>jo", ":JiraOpen<cr>", desc = "Open Jira issue in browser", silent = true },
  },
}
