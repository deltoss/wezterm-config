local wezterm = require("wezterm")

local module = {}

-- The suggested convention for making modules that update
-- the config is for them to export an `apply_to_config`
-- function that accepts the config object.
function module.apply_to_config(config)
  if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    config.default_prog = { "nu" }

    config.launch_menu = {
      {
        label = "Default Shell",
        args = {},
      },
      {
        label = "PowerShell",
        args = { "pwsh", "-NoLogo" },
      },
      {
        label = "Admin PowerShell",
        args = { "pwsh", "-NoProfile", "-NoLogo", "-c", "gsudo" },
      },
      {
        label = "Admin Nushell",
        args = { "nu", "--no-config-file", "--no-std-lib", "-c", "gsudo" },
      },
      {
        label = "Neovim",
        args = {
          "nvim",
        },
      },
      {
        label = "Yazi",
        args = { "nu", "-e", "y" },
      },
      {
        label = "Neovim: Note Taking",
        args = { "nu", "--no-config-file", "--no-std-lib", "-c", 'cd (zoxide query "Note Taking"); nvim .' },
      },
      {
        label = "Neovim: Org Notes",
        args = { "nu", "--no-config-file", "--no-std-lib", "-c", 'cd (zoxide query "Org Notes"); nvim .' },
      },
      {
        label = "Neovim: Neovim Configs",
        args = { "nu", "--no-config-file", "--no-std-lib", "-c", "cd (zoxide query .config nvim); nvim ." },
      },
      {
        label = "Neovim: Wezterm Configs",
        args = { "nu", "--no-config-file", "--no-std-lib", "-c", "cd (zoxide query .config wezterm); nvim ." },
      },
      {
        label = "Neovim: Powershell Profile",
        args = { "nu", "--no-config-file", "--no-std-lib", "-c", "cd (zoxide query .config PowerShell); nvim ." },
      },
      {
        label = "Neovim: Nushell Configs",
        args = { "nu", "--no-config-file", "--no-std-lib", "-c", "cd (zoxide query .config nushell); nvim ." },
      },
      {
        label = "Neovim: Chezmoi - Personal/Work",
        args = { "nu", "--no-config-file", "--no-std-lib", "-c", "cd (chezmoi source-path); nvim ." },
      },
      {
        label = "Neovim: Chezmoi - Servers",
        args = { "nu", "--no-config-file", "--no-std-lib", "-c", "cd (zoxide query serversdotfiles); nvim ." },
      },
    }
  end
end

return module
