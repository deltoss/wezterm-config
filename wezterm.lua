local wezterm = require("wezterm")

require("configs.status-bar")

local config = wezterm.config_builder()

require("configs.multiplexer").apply_to_config(config)
require("configs.launch").apply_to_config(config)
require("configs.ssh").apply_to_config(config)
require("configs.appearance").apply_to_config(config)
require("configs.tab-title").apply_to_config(config)
require("configs.window-title").apply_to_config(config)
require("configs.quick-select").apply_to_config(config)
require("configs.keys").apply_to_config(config)
require("plugins.smart-splits-nvim").apply_to_config(config)

return config
