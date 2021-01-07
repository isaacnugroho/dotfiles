local awful = require("awful")
local beautiful = require("beautiful")
local debug = require("gears.debug")

local titlebar_shown = setmetatable({}, { __mode = 'k' })

local _M = {}

function _M.show_titlebar(c, position)
  titlebar_shown[c] = true
  position = position or "top"
  if position == "top" or position == "bottom" then
    c:relative_move(0, 0, 0, -beautiful.titlebar_height)
  else
    c:relative_move(0, 0, -beautiful.titlebar_height, 0)
  end
  RC.functions.awful_titlebar_show(c, position)
end

function _M.hide_titlebar(c, position)
  titlebar_shown[c] = false
  position = position or "top"
  RC.functions.awful_titlebar_hide(c, position)
  if position == "top" or position == "bottom" then
    c:relative_move(0, 0, 0, beautiful.titlebar_height)
  else
    c:relative_move(0, 0, beautiful.titlebar_height, 0)
  end
end

function _M.toggle_titlebar(c, position)
  local shown = titlebar_shown[c]
  if shown == nil then
    shown = c. titlebars_enabled
  end
  if shown then
    _M.hide_titlebar(c, position)
  else
    _M.show_titlebar(c, position)
  end
end

function _M.titlebar_created(c)
  titlebar_shown[c] = true
end

function _M.init()
  if not RC.functions then
    RC.functions = {}
  end
  if not RC.functions.awful_titlebar_show then
    RC.functions.awful_titlebar_show = awful.titlebar.show
    RC.functions.awful_titlebar_hide = awful.titlebar.hide
    RC.functions.awful_titlebar_toggle = awful.titlebar.toggle
    awful.titlebar.show = _M.show_titlebar
    awful.titlebar.hide = _M.hide_titlebar
    awful.titlebar.toggle = _M.toggle_titlebar
  end
end

return {
  titlebar_created = _M.titlebar_created,
  init = _M.init,
}
