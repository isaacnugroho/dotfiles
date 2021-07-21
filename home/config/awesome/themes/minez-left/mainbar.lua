local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
--local mykeyboardlayout = awful.widget.keyboardlayout()

local function init()
  local battery_widget = dofile(RC.theme_path .. 'widgets/battery-widget/battery.lua')

  -- Create a textclock widget
  local mytextclock = wibox.widget.textclock()

  local mylauncher = awful.widget.launcher({
    image = beautiful.awesome_icon,
    menu = RC.main_menu
  })

  --log.debug(RC.main_menu or "main_menu not found")
  screen.connect_signal("request::desktop_decoration",
      function(s)
        -- Each screen has its own tag table.
        awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

        -- Create a promptbox for each screen
        s.mypromptbox = awful.widget.prompt()

        -- Create an imagebox widget which will contain an icon indicating which layout we're using.
        -- We need one layoutbox per screen.
        s.mylayoutbox = awful.widget.layoutbox {
          screen = s,
          buttons = {
            awful.button({ }, 1,
                function()
                  awful.layout.inc(1)
                end),
            awful.button({ }, 3,
                function()
                  awful.layout.inc(-1)
                end),
            awful.button({ }, 4,
                function()
                  awful.layout.inc(-1)
                end),
            awful.button({ }, 5,
                function()
                  awful.layout.inc(1)
                end),
          }
        }

        -- Create a taglist widget
        s.mytaglist = awful.widget.taglist {
          screen = s,
          filter = awful.widget.taglist.filter.all,
          buttons = {
            awful.button({ }, 1,
                function(t)
                  t:view_only()
                end),
            awful.button({ modkey }, 1,
                function(t)
                  if client.focus then
                    client.focus:move_to_tag(t)
                  end
                end),
            awful.button({ }, 3, awful.tag.viewtoggle),
            awful.button({ modkey }, 3,
                function(t)
                  if client.focus then
                    client.focus:toggle_tag(t)
                  end
                end),
            awful.button({ }, 4,
                function(t)
                  awful.tag.viewprev(t.screen)
                end),
            awful.button({ }, 5,
                function(t)
                  awful.tag.viewnext(t.screen)
                end),
          }
        }

        if beautiful.taglist_shape_container then
          local background_shape_wrapper = wibox.container.background(s.mytaglist)
          background_shape_wrapper._do_taglist_update_now = s.mytaglist._do_taglist_update_now
          background_shape_wrapper._do_taglist_update = s.mytaglist._do_taglist_update
          background_shape_wrapper.shape = beautiful.taglist_shape_container
          background_shape_wrapper.shape_clip = beautiful.taglist_shape_clip_container
          background_shape_wrapper.shape_border_width = beautiful.taglist_shape_border_width_container
          background_shape_wrapper.shape_border_color = beautiful.taglist_shape_border_color_container
          s.mytaglist = background_shape_wrapper
        end

        -- Create a tasklist widget
        s.mytasklist = awful.widget.tasklist {
          screen = s,
          filter = awful.widget.tasklist.filter.currenttags,
          widget_template = beautiful.tasklist_widget_template,
          buttons = {
            awful.button({ }, 1,
                function(c)
                  c:activate { context = "tasklist", action = "toggle_minimization" }
                end),
            awful.button({ }, 3,
                function()
                  awful.menu.client_list { theme = { width = 250 } }
                end),
            awful.button({ }, 4,
                function()
                  awful.client.focus.byidx(-1)
                end),
            awful.button({ }, 5,
                function()
                  awful.client.focus.byidx(1)
                end),
          },
          layout = {
            layout = wibox.layout.align.vertical,
          },
        }

        -- Create the wibox

        s.mainbar = awful.wibar({ position = "left", screen = s })

        -- Add widgets to the wibox
        local systray = wibox.widget.systray()
        systray:set_horizontal(false)
        local bottom_layout = wibox.layout.fixed.horizontal()
        bottom_layout:add(s.mylayoutbox)
        bottom_layout:add(mytextclock)
        bottom_layout:add(systray)
        bottom_layout:add(battery_widget({
          font = beautiful.font,
          display_notification = true,
        }))
        local top_layout = wibox.layout.fixed.horizontal()
        top_layout:add(s.mypromptbox)
        top_layout:add(s.mytaglist)

        local layout = wibox.layout.align.horizontal()
        layout:set_first(bottom_layout)
        layout:set_third(top_layout)

        local rotate =wibox.layout.rotate()
        rotate:set_direction("east")
        rotate:set_widget(layout)

        local wibox_layout = wibox.layout.fixed.vertical()
        wibox_layout:add(mylauncher)
        wibox_layout:add(s.mytasklist)
        wibox_layout:add(rotate)

        s.mainbar.widget = wibox_layout
      end)
end

return {
  init = init,
}