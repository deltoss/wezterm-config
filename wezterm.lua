local wezterm = require("wezterm")

local config = wezterm.config_builder()

require("configs.multiplexer").apply_to_config(config)
require("configs.launch").apply_to_config(config)
require("configs.ssh").apply_to_config(config)
require("configs.appearance").apply_to_config(config)
require("configs.tabtitle").apply_to_config(config)
require("configs.keys").apply_to_config(config)
require("plugins.smart-splits-nvim").apply_to_config(config)

return config
