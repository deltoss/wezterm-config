local wezterm = require("wezterm")

local module = {}

-- The suggested convention for making modules that update
-- the config is for them to export an `apply_to_config`
-- function that accepts the config object.
function module.apply_to_config(config)
  if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    config.default_prog =
      { "nu", "--no-config-file", "--no-std-lib", "~/.config/nushell/custom-commands/quick-launch.nu" }
  end
end

return module
