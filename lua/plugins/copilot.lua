return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = false,
        help = false,
      },
      copilot_node_command = "/home/nelson/.nvm/versions/node/v22.11.0/bin/node",
    },
  },
}
