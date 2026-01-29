return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    build = ":Copilot auth",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<M-l>",
          accept_word = false,
          accept_line = false,
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      panel = { enabled = true, auto_refresh = false },
      filetypes = {
        markdown = false,
        help = false,
      },
      copilot_node_command = "/home/nelson/.nvm/versions/node/v24.13.0/bin/node",
    },
  },
}
