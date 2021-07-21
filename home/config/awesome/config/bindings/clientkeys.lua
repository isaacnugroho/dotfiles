-- Standard Awesome library
local gears = require("gears")
local awful = require("awful")

local _M = {}

function _M.get()
  local clientkeys = gears.table.join(
      awful.key({ modkey }, "f",
          function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
          end,
          { description = "toggle fullscreen", group = "client" }
      ),
      awful.key({ modkey, }, "x",
          function(c)
            c:kill()
          end,
          { description = "close", group = "client" }
      ),
      awful.key({ modkey, "Control" }, "space",
          awful.client.floating.toggle,
          { description = "toggle floating", group = "client" }
      ),
      awful.key({ modkey, "Control" }, "Return",
          function(c)
            c:swap(awful.client.getmaster())
          end,
          { description = "move to master", group = "client" }
      ),
      awful.key({ modkey }, "o",
          function(c)
            c:move_to_screen()
            client.focus = c
            c:raise()
          end,
          { description = "move to screen", group = "client" }
      ),
      awful.key({ modkey }, "t",
          function(c)
            c.ontop = not c.ontop
          end,
          { description = "toggle keep on top", group = "client" }
      ),
      awful.key({ modkey }, "n",
          function(c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
          end,
          { description = "minimize", group = "client" }
      ),

      awful.key({ modkey, "Control" }, "t",
          function(c)
            awful.titlebar.toggle(c, "top")
          end,
          { description = "toggle titlebar", group = "client" }
      ),
  -- Maximized
      awful.key({ modkey }, "m",
          function(c)
            c.maximized = not c.maximized
            if (not c.maximized) then
              awful.titlebar.show(c)
            end
            c:raise()
          end,
          { description = "(un)maximize", group = "client" }
      ),
      awful.key({ modkey, "Control" }, "m",
          function(c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
          end,
          { description = "(un)maximize vertically", group = "client" }
      ),
      awful.key({ modkey, "Shift" }, "m",
          function(c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
          end,
          { description = "(un)maximize horizontally", group = "client" }
      ),
  -- Resize
      awful.key({ modkey, "Control" }, "Down",
          function(c)
            if c.maximized then
              c.maximized = false
            else
              c:relative_move(0, 0, 0, 16)
            end
          end,
          { description = "increase height", group = "client" }
      ),
      awful.key({ modkey, "Control" }, "Up",
          function(c)
            if c.maximized then
              c.maximized = false
            else
              c:relative_move(0, 0, 0, -16)
            end
          end,
          { description = "decrease height", group = "client" }
      ),
      awful.key({ modkey, "Control" }, "Left",
          function(c)
            if c.maximized then
              c.maximized = false
            else
              c:relative_move(0, 0, -16, 0)
            end
          end,
          { description = "decrease width", group = "client" }
      ),
      awful.key({ modkey, "Control" }, "Right",
          function(c)
            if c.maximized then
              c.maximized = false
            else
              c:relative_move(0, 0, 16, 0)
            end
          end,
          { description = "increase width", group = "client" }
      ),
      awful.key({ modkey, "Control", "Shift" }, "Down",
          function(c)
            if c.maximized then
              c.maximized = false
            else
              c:relative_move(0, -8, 0, 16)
            end
          end,
          { description = "increase height", group = "client" }
      ),
      awful.key({ modkey, "Control", "Shift" }, "Up",
          function(c)
            if c.maximized then
              c.maximized = false
            else
              c:relative_move(0, 8, 0, -16)
            end
          end,
          { description = "decrease height", group = "client" }
      ),
      awful.key({ modkey, "Control", "Shift" }, "Left",
          function(c)
            if c.maximized then
              c.maximized = false
            else
              c:relative_move(8, 0, -16, 0)
            end
          end,
          { description = "increase width", group = "client" }
      ),
      awful.key({ modkey, "Control", "Shift" }, "Right",
          function(c)
            if c.maximized then
              c.maximized = false
            else
              c:relative_move(-8, 0, 16, 0)
            end
          end,
          { description = "decrease width", group = "client" }
      ),
  -- Move
      awful.key({ modkey, "Shift" }, "Down",
          function(c)
            if c.maximized then
              c.maximized = false
            else
              c:relative_move(0, 16, 0, 0)
            end
          end,
          { description = "move down", group = "client" }
      ),
      awful.key({ modkey, "Shift" }, "Up",
          function(c)
            if c.maximized then
              c.maximized = false
            else
              c:relative_move(0, -16, 0, 0)
            end
          end,
          { description = "move up", group = "client" }
      ),
      awful.key({ modkey, "Shift" }, "Left",
          function(c)
            if c.maximized then
              c.maximized = false
            else
              c:relative_move(-16, 0, 0, 0)
            end
          end,
          { description = "move left", group = "client" }
      ),
      awful.key({ modkey, "Shift" }, "Right",
          function(c)
            if c.maximized then
              c.maximized = false
            else
              c:relative_move(16, 0, 0, 0)
            end
          end,
          { description = "move right", group = "client" }
      ),
      awful.key({ modkey, "Shift" }, "Next",
          function(c)
            if c.maximized then
              c.maximized = false
            else
              c:relative_move(16, 16, -32, -32)
            end
          end,
          { description = "decrease width and height", group = "client" }
      ),
      awful.key({ modkey, "Shift" }, "Prior",
          function(c)
            if c.maximized then
              c.maximized = false
            else
              c:relative_move(-16, -16, 32, 32)

            end
          end,
          { description = "increase width and height", group = "client" }
      )
  )

  return clientkeys
end

return setmetatable(
    {},
    {
      __call = function(_, ...)
        return _M.get(...)
      end
    }
)
