local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

local function create_titlebar(c)
  -- buttons for the titlebar
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

  local titlebar_height = beautiful.titlebar_height or 20
  local titlewidget = awful.titlebar.widget.titlewidget(c)

  local theme = beautiful.get()
  if theme then
    titlewidget.font = beautiful.titlebar_font_normal
  end

  awful.titlebar(c, { size = titlebar_height }):setup {
    { -- Left
      awful.titlebar.widget.iconwidget(c),
      buttons = buttons,
      layout = wibox.layout.fixed.horizontal
    },
    { -- Middle
      { -- Title
        align = "center",
        widget = titlewidget,
      },
      buttons = buttons,
      layout = wibox.layout.flex.horizontal
    },
    { -- Right
      awful.titlebar.widget.floatingbutton(c),
      awful.titlebar.widget.stickybutton(c),
      awful.titlebar.widget.ontopbutton(c),
      awful.titlebar.widget.maximizedbutton(c),
      awful.titlebar.widget.minimizebutton(c),
      awful.titlebar.widget.closebutton(c),
      layout = wibox.layout.fixed.horizontal(),
    },
    layout = wibox.layout.align.horizontal
  }
end

return {
  create_titlebar = create_titlebar,
}