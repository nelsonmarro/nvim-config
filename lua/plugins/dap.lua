return {
  "mfussenegger/nvim-dap",
  recommended = true,
  desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",
  config = function(_, opts)
    local dap = require("dap")

    dap.adapters.godot = {
      type = "server",
      host = "127.0.0.1",
      port = 6006,
    }

    dap.configurations.gdscript = {
      {
        type = "godot",
        request = "launch",
        name = "Launch Scene",
        project = "${workspaceFolder}", -- This variable points to the project root
        launch_scene = true,
      },
    }
  end,
}
