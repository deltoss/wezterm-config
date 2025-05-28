local wezterm = require("wezterm")
local config = wezterm.config_builder()

require("configs.launch").apply_to_config(config)
require("configs.appearance").apply_to_config(config)

return config
