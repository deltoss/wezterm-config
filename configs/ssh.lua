local module = {}

-- The suggested convention for making modules that update
-- the config is for them to export an `apply_to_config`
-- function that accepts the config object.
function module.apply_to_config(config)
	-- To use OS's default SSH agent (OpenSSH for Windows)
	config.mux_enable_ssh_agent = false
end

return module
