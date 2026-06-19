local wezterm = require("wezterm")

local module = {}

-- The suggested convention for making modules that update
-- the config is for them to export an `apply_to_config`
-- function that accepts the config object.
function module.apply_to_config(config)
  if not os.getenv("ZELLIJ_CONFIG_DIR") then
    local xdg = os.getenv("XDG_CONFIG_HOME")
    if xdg then
      config.default_prog = { "zellij", "--config-dir", xdg .. "/zellij", "--layout", "quick-launch" }
    else
      config.default_prog = { "zellij" }
    end
  end
  config.launch_menu = {
    {
      label = "Default Shell",
      args = { "nu" },
    },
    {
      label = "Zellij",
      args = {},
    },
  }
end

return module
