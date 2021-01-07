local awful = require("awful")
local lfs = require("lfs")
local debug = require("gears.debug")

local _M = {}
_M.log_level = "WARNING"
_M.log_level_value = 0

local log_table = {
  ERROR = "0",
  WARNING = "1",
  INFO = "2",
  DEBUG = "3",
  TRACE = "4",
}

function _M.run_apps_in(path)
  if lfs.chdir(path) then
    local apps = {}
    for file in lfs.dir(path) do
      local sh_ext = ".sh"
      local ext = file:sub(-#sh_ext)
      if sh_ext == ext then
        table.insert(apps, path .. file)
      end
    end
    table.sort(apps)

    for app = 1, #apps do
      awful.spawn.with_shell(apps[app])
    end
  end
end

function _M.error(arg)
  debug.dump(arg)
end

function _M.warning(arg)
  if _M.log_level_value > 0 then
    debug.dump(arg)
  end
end

function _M.info(arg)
  if _M.log_level_value > 1 then
    debug.dump(arg)
  end
end

function _M.debug(arg)
  if _M.log_level_value > 2 then
    debug.dump(arg)
  end
end

function _M.trace(arg)
  if _M.log_level_value > 3 then
    debug.dump(arg)
  end
end

function _M.level(arg)
  if arg then
    arg = string.upper(tostring(arg))
    for k, v in ipairs(log_table) do
      if arg == k or arg == v then
        _M.log_level = k
        _M.log_level_value = v
        break
      end
    end
  end
  return _M.log_level
end

return {
  run_apps_in = _M.run_apps_in,
  log = {
    error = _M.error,
    warning = _M.warning,
    info = _M.info,
    debug = _M.debug,
    trace = _M.trace,
    level = _M.level,
  },
}
