return {
  {
    "kid-icarus/jira.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim", -- optional
      "folke/snacks.nvim", -- optional
    },
    opts = {
      jira_api = {
        domain = vim.env.JIRA_DOMAIN,
        username = vim.env.JIRA_USER,
        token = vim.env.JIRA_API_TOKEN,
      },
      use_git_branch_issue_id = true,
      git_trunk_branch = "main", -- The main branch of your project
      git_branch_prefix = "feature/", -- The prefix for your feature branches
    }, -- see configuration section
  },
}
