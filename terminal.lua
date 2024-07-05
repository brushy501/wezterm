local term = require("wezterm")

local M = {}

function M.options(config)
  -- color scheme
  config.color_scheme = "Tokyo Night"
  --- font config
  config.font_size = 12
  config.font = term.font_with_fallback({
    { family = "Lilex Nerd Font" },
    { family = "FiraCode Nerd Font" }
  })
  -- Window settings
  config.window_background_opacity = 0.85
  config.window_decorations = "RESIZE"
  config.window_close_confirmation = "AlwaysPrompt"
  config.scrollback_lines = 5000

  -- Workspace settings
  config.default_workspace = "Home"
  -- Inactive Pane
  config.inactive_pane_hsb = {
    saturation = 0.24,
    brightness = 0.5
  }
  config.colors = {
    tab_bar = {
      active_tab = {
        bg_color = "#ffba08",
        fg_color = "#03071e",
      }
    }
  }
  config.window_frame = {

  }
end

return M
