local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.mux_enable_ssh_agent = false

require("configs.launch").apply_to_config(config)
require("configs.appearance").apply_to_config(config)
require("plugins.smart-splits-nvim").apply_to_config(config)

return config
