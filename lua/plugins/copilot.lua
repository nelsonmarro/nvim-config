return {
  {
    "zbirenbaum/copilot.lua",
    enabled = false,
    cmd = "Copilot",
    event = "InsertEnter",
    build = ":Copilot auth",
    opts = function()
      LazyVim.cmp.actions.ai_accept = function()
        if require("copilot.suggestion").is_visible() then
          LazyVim.create_undo()
          require("copilot.suggestion").accept()
          return true
        end
      end

      return {
        suggestion = {
          enabled = true,
          auto_trigger = true,
          hide_during_completion = true,
          keymap = {
            accept = "<M-l>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<M-e>",
          },
        },
        panel = { enabled = false },
        filetypes = {
          markdown = false,
          help = false,
        },
        copilot_node_command = "/home/nelson/.nvm/versions/node/v24.13.0/bin/node",
      }
    end,
  },
}
