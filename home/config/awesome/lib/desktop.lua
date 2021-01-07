local beautiful = require("beautiful")
local awful = require("awful")
local gears = require("gears")

local _desktop = {
  wallpaper = RC.properties.default_wallpaper,
}

function _desktop.set_wallpaper(s, img)
  --gears.debug.dump("set_wallpaper: " .. (img or "nil"))
  if not img then
    if _desktop.wallpaper then
      img = _desktop.wallpaper
    elseif s and beautiful.wallpaper then
      local wallpaper = beautiful.wallpaper
      -- If wallpaper is a function, call it with the screen
      if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
      end
      img = wallpaper
    end
  end
  if img then
    if not s then
      _desktop.wallpaper = img
      gears.wallpaper.maximized(img, nil, true)
    else
      gears.wallpaper.maximized(img, s, true)
    end
  end
end

function _desktop.for_each_screen(s)
  --gears.debug.dump("for_each_screen")
  --gears.debug.dump(s.outputs)
end

function _desktop.handle_outputs(s)
  --gears.debug.dump("property::outputs")
  --gears.debug.dump(s.outputs)
end

function _desktop.handle_viewports(s)
  --gears.debug.dump("property::viewports")
  --gears.debug.dump(s.outputs)
end

function _desktop.handle_list(s)
  log.debug("list")
  --gears.debug.dump(s.outputs)
end

function _desktop.handle_added(s)
  _desktop.set_wallpaper(s, nil)
end

function _desktop.handle_removed(s)
  _desktop.set_wallpaper(s, nil)
end

function _desktop.handle_primary_changed(s)
  _desktop.set_wallpaper(s, nil)
end

function _desktop.init()
  if not RC.functions then
    RC.functions = {}
  end
  --for s in screen do
  --  print("Oh, wow, we have screen " .. s.name)
  --  gears.debug.dump(s)
  --  gears.debug.dump(s.outputs)
  --  --gears.debug.dump(s.outputs.default.mm_height)
  --end
  --awful.screen.connect_for_each_screen(_desktop.for_each_screen)
  --screen.connect_signal("property::outputs", _desktop.handle_outputs)
  --screen.connect_signal("property::viewports", _desktop.handle_viewports)
  --screen.connect_signal("list", _desktop.handle_list)
  awful.screen.set_auto_dpi_enabled(true)
  screen.connect_signal("added", _desktop.handle_added)
  screen.connect_signal("removed", _desktop.handle_removed)
  screen.connect_signal("primary_changed", _desktop.handle_primary_changed)

  RC.functions.set_wallpaper = _desktop.set_wallpaper

  screen.connect_signal("request::wallpaper",
      function(s)
        _desktop.set_wallpaper(s, nil)
      end)
end

return {
  set_wallpaper = _desktop.set_wallpaper,
  init = _desktop.init,
}