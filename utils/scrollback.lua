local wezterm = require("wezterm")
local io = require("io")
local os = require("os")
local act = wezterm.action

-- Neovim runs -c after reading the file. Keep the text in a scratch buffer
-- before deleting the temporary file, regardless of how long startup takes.
local prepare_scrollback = ([[lua
  local path = vim.fn.argv(0)
  local buf = vim.fn.bufnr(path)
  if buf < 0 or not vim.api.nvim_buf_is_loaded(buf) then return end
  vim.bo[buf].buftype = 'nofile'
  vim.bo[buf].bufhidden = 'wipe'
  vim.bo[buf].swapfile = false
  vim.bo[buf].modified = false
  local ok, err = os.remove(path)
  if not ok then vim.notify('Scrollback cleanup: ' .. err, vim.log.levels.WARN) end
]]):gsub("\n", " ")

-- See https://wezterm.org/config/lua/pane/get_lines_as_text.html
wezterm.on("trigger-editor-with-scrollback", function(window, pane)
  local text = pane:get_lines_as_text(pane:get_dimensions().scrollback_rows)
  local name = os.tmpname()
  local f, open_error = io.open(name, "wb")
  if not f then
    os.remove(name)
    wezterm.log_error("Cannot create scrollback file: " .. open_error)
    return
  end
  local written, write_error = f:write(text)
  local closed, close_error = f:close()
  if not written or not closed then
    os.remove(name)
    wezterm.log_error("Cannot write scrollback file: " .. (write_error or close_error))
    return
  end

  local ok, spawn_error = pcall(
    window.perform_action,
    window,
    act.SpawnCommandInNewTab({
      args = { "nvim", "-n", "-R", "-c", prepare_scrollback, "--", name },
      -- The temporary file belongs to this machine, even for SSH panes.
      domain = { DomainName = "local" },
    }),
    pane
  )
  if not ok then
    os.remove(name)
    wezterm.log_error("Cannot open scrollback: " .. tostring(spawn_error))
  end
end)
