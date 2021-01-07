-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

local _M = {}

function _M.get()
  local clientbuttons = gears.table.join(
      awful.button({ }, 1,
          function(c)
            c:activate { context = "mouse_click" }
          end),
      awful.button({ "Mod1" }, 1,
          function(c)
            if (c.maximized) then
              c.maximized = false
            end
            c:activate { context = "mouse_click", action = "mouse_move" }
          end),
      awful.button({ "Mod1" }, 3,
          function(c)
            c:activate { context = "mouse_click", action = "mouse_resize" }
          end)
  )

  return clientbuttons
end

return setmetatable({}, {
  __call = function(_, ...)
    return _M.get(...)
  end
})
