local module = {}

-- The suggested convention for making modules that update
-- the config is for them to export an `apply_to_config`
-- function that accepts the config object.
function module.apply_to_config(config)
  config.quick_select_patterns = {
    "^\\s*(\\S.+)\\s*$", -- Anything
  }
end

return module
