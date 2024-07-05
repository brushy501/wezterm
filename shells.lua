local term = require("wezterm")

local M = {}

function M.options(config)
  config.prefer_egl = true
  config.default_prog = { "pwsh" }

  config.launch_menu = {
    { label = " Bash", args = { "C:/Program Files/Git/bin/bash.exe", "-li" } },
    { label = " PowerShell", args = { "pwsh" } },
    { label = " Nushell", args = { "nu" } },
    { label = " Cmd", args = { "cmd" } },
    {
      label = " NeoVim Config",
      args = { "pwsh", "-NoExit", "-Command", "cd C:/Users/User/AppData/Local/nvim && nvim" },
    },
  }
end

return M
