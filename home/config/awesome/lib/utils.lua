local awful = require("awful")
local lfs = require("lfs")
local debug = require("gears.debug")
local lgi = require('lgi')
local gtk = lgi.require('Gtk')

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

_M.icon_theme = nil

local gtk_icon_theme = gtk.IconTheme.get_default()

all_icon_sizes = {
  'apps',
  'actions',
  'devices',
  'places',
  'categories',
  'status',
  'mimetypes',
  '128x128',
  '96x96',
  '72x72',
  '64x64',
  '48x48',
  '36x36',
  '32x32',
  '24x24',
  '22x22',
  '16x16',
  '8x8',
  'scalable'
}
all_icon_types = {
  '128',
  '96',
  '72',
  '64',
  '48',
  '36',
  '32',
  '24',
  '22',
  '16',
  'mimetypes',
  'apps',
  'actions',
  'devices',
  'places',
  'categories',
  'status',
  'mimetypes'
}
all_icon_paths = { os.getenv("HOME") .. '/.icons/', '/usr/share/icons/' }

icon_sizes = {}

function _M.lookup_icon(icon)
  if icon:sub(1, 1) == '/' and (icon:find('.+%.png') or icon:find('.+%.xpm') or icon:find('.+%.svg')) then
    -- icons with absolute path and supported (AFAICT) formats
    return icon
  else
    local gtk_icon_info = gtk.IconTheme.lookup_icon(gtk_icon_theme, icon, 48, 0)
    if gtk_icon_info then
      filename = gtk.IconInfo.get_filename(gtk_icon_info)
      if filename then
        return filename
      end
    end

    local icon_path = {}
    local icon_themes = {}
    local icon_theme_paths = {}
    if icon_theme and type(icon_theme) == 'table' then
      icon_themes = icon_theme
    elseif icon_theme then
      icon_themes = { icon_theme }
    end
    for i, theme in ipairs(icon_themes) do
      for j, path in ipairs(all_icon_paths) do
        table.insert(icon_theme_paths, path .. theme .. '/')
      end
      -- TODO also look in parent icon themes, as in freedesktop.org specification
    end
    table.insert(icon_theme_paths, '/usr/share/icons/gnome/') -- fallback theme cf spec

    local isizes = icon_sizes
    for i, sz in ipairs(all_icon_sizes) do
      table.insert(isizes, sz)
    end

    for i, icon_theme_directory in ipairs(icon_theme_paths) do
      for j, size in ipairs(icon_sizes or isizes) do
        for k, icon_type in ipairs(all_icon_types) do
          table.insert(icon_path, icon_theme_directory .. size .. '/' .. icon_type .. '/')
        end
      end
    end

    -- lowest priority fallbacks
    table.insert(icon_path,  '/usr/share/pixmaps/')
    table.insert(icon_path,  '/usr/share/icons/')
    table.insert(icon_path,  '/usr/share/app-install/icons/')

    for i, directory in ipairs(icon_path) do
      if (icon:find('.+%.png') or icon:find('.+%.xpm') or icon:find('.+%.svg')) and module.file_exists(directory .. icon) then
        return directory .. icon
      elseif module.file_exists(directory .. icon .. '.png') then
        return directory .. icon .. '.png'
      elseif module.file_exists(directory .. icon .. '.xpm') then
        return directory .. icon .. '.xpm'
      elseif module.file_exists(directory .. icon .. '.svg') then
        return directory .. icon .. '.svg'
      end
    end
  end
end

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
  lookup_icon = _M.lookup_icon,
  log = {
    error = _M.error,
    warning = _M.warning,
    info = _M.info,
    debug = _M.debug,
    trace = _M.trace,
    level = _M.level,
  },
}
