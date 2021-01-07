local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local ruled = require("ruled")
local gears = require("gears")
local wibox = require("wibox")
local functions = require("lib.functions")

require("awful.autofocus")

client.connect_signal("manage",
    function(c)
      if awesome.startup then
        if not c.size_hints.user_position
            and not c.size_hints.program_position then
          -- Prevent clients from being unreachable after screen count changes.
          awful.placement.no_offscreen(c)
        end
      end
      if c.maximized then
        awful.titlebar.hide(c)
      end
    end)

client.connect_signal("focus",
    function(c)
      c.border_color = beautiful.border_focus
    end)

client.connect_signal("unfocus",
    function(c)
      c.border_color = beautiful.border_normal
    end)

client.connect_signal("property::maximized",
    function(c)
      if (c.maximized) then
        awful.titlebar.hide(c)
        local curr_screen_workarea = c.screen.workarea
        c.border_width = 0
        c:geometry{
          x = curr_screen_workarea.x,
          y = curr_screen_workarea.y,
          width = curr_screen_workarea.width,
          height = curr_screen_workarea.height,
        }
      else
        c.border_width = beautiful.border_width
      end
    end)

ruled.client.connect_signal("request::rules",
    function()
      -- All clients will match this rule.
      ruled.client.append_rule(RC.rules)
    end)

client.connect_signal("request::default_mousebindings",
    function()
      awful.mouse.append_client_mousebindings(RC.bindings.clientbuttons)
    end)

client.connect_signal("request::default_keybindings",
    function()
      awful.keyboard.append_client_keybindings(RC.bindings.clientkeys)
    end)

ruled.notification.connect_signal('request::rules',
    function()
      -- All notifications will match this rule.
      ruled.notification.append_rule {
        rule = { },
        properties = {
          screen = awful.screen.preferred,
          implicit_timeout = 5,
        }
      }
    end)

naughty.connect_signal("request::display",
    function(n)
      naughty.layout.box { notification = n }
    end)

-- }}}

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter",
    function(c)
      c:activate { context = "mouse_enter", raise = false }
    end)

client.connect_signal("request::titlebars",
    function(c)
      if RC.functions.create_titlebar then
        RC.functions.create_titlebar(c)
      else -- default titlebar
        local buttons = gears.table.join(
            awful.button({ }, 1,
                function()
                  c:emit_signal("request::activate", "titlebar", { raise = true })
                  awful.mouse.client.move(c)
                end),
            awful.button({ }, 3,
                function()
                  c:emit_signal("request::activate", "titlebar", { raise = true })
                  awful.mouse.client.resize(c)
                end))

        awful.titlebar(c, { size = titlebar_height }):setup {
          { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout = wibox.layout.fixed.horizontal
          },
          { -- Middle
            { -- Title
              align = "center",
              widget = awful.titlebar.widget.titlewidget(c),
            },
            buttons = buttons,
            layout = wibox.layout.flex.horizontal
          },
          { -- Right
            awful.titlebar.widget.floatingbutton(c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.minimizebutton(c),
            awful.titlebar.widget.closebutton(c),
            layout = wibox.layout.fixed.horizontal(),
          },
          layout = wibox.layout.align.horizontal
        }
      end
      functions.titlebar_created(c)
    end)
