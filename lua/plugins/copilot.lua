return {
  {
    "zbirenbaum/copilot.lua",
    depenencies = {
      "copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
    },
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      filetypes = {
        markdown = false,
        help = false,
      },
      copilot_node_command = "/home/nelson/.nvm/versions/node/v24.13.0/bin/node",
    },
  },
}
