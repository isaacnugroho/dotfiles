-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local menubar = require("menubar")

local _M = {}

function _M.get()
  local globalkeys = gears.table.join(
      awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),

  -- Tag browsing
      awful.key({ modkey }, "Left",
          awful.tag.viewprev,
          { description = "view previous", group = "tag" }),

      awful.key({ modkey }, "Right",
          awful.tag.viewnext,
          { description = "view next", group = "tag" }),

      awful.key({ modkey }, "Escape",
          awful.tag.history.restore,
          { description = "go back", group = "tag" }),

      awful.key({ modkey }, "j",
          function()
            awful.client.focus.byidx(1)
          end,
          { description = "focus next by index", group = "client" }
      ),
      awful.key({ modkey }, "k",
          function()
            awful.client.focus.byidx(-1)
          end,
          { description = "focus previous by index", group = "client" }
      ),
      awful.key(
          { "Mod1" }, "Tab",
          function()
            awful.client.focus.byidx(1)
          end,
          { description = "focus next by index", group = "client" }
      ),
      awful.key(
          { "Mod1", "Shift" }, "Tab",
          function()
            awful.client.focus.byidx(-1)
          end,
          { description = "focus previous by index", group = "client" }
      ),
      awful.key({ modkey }, "w",
          function()
            RC.main_menu:show()
          end,
          { description = "show main menu", group = "awesome" }
      ),
      awful.key({ modkey }, "z",
          function()
            focused = awful.screen.focused()
            if (focused) then
              focused.mainbar.visible = not focused.mainbar.visible
            end
          end,
          { description = "toggle mainbar", group = "awesome" }
      ),
  -- Layout manipulation
      awful.key({ modkey, "Shift" }, "j",
          function()
            awful.client.swap.byidx(1)
          end,
          { description = "swap with next client by index", group = "client" }
      ),
      awful.key({ modkey, "Shift" }, "k",
          function()
            awful.client.swap.byidx(-1)
          end,
          { description = "swap with previous client by index", group = "client" }
      ),
      awful.key({ modkey, "Control" }, "j",
          function()
            awful.screen.focus_relative(1)
          end,
          { description = "focus the next screen", group = "screen" }
      ),
      awful.key({ modkey, "Control" }, "k",
          function()
            awful.screen.focus_relative(-1)
          end,
          { description = "focus the previous screen", group = "screen" }
      ),
      awful.key({ modkey }, "u",
          awful.client.urgent.jumpto,
          { description = "jump to urgent client", group = "client" }),
      awful.key({ modkey }, "Tab",
          function()
            awful.client.focus.history.previous()
            if client.focus then
              client.focus:raise()
            end
          end,
          { description = "go back", group = "client" }
      ),
  -- Standard program
      awful.key({ modkey }, "Return",
          function()
            awful.spawn.raise_or_spawn(terminal .. " -d=~", {
              skip_taskbar = true
            })
          end,
          { description = "open a terminal", group = "launcher" }
      ),

      awful.key({ modkey, "Control" }, "r",
          awesome.restart,
          { description = "reload awesome", group = "awesome" }),

      awful.key({ modkey, "Shift" }, "q",
          awesome.quit,
          { description = "quit awesome", group = "awesome" }),

  -- Layout manipulation
      awful.key({ modkey }, "l",
          function()
            awful.tag.incmwfact(0.05)
          end,
          { description = "increase master width factor", group = "layout" }
      ),
      awful.key({ modkey }, "h",
          function()
            awful.tag.incmwfact(-0.05)
          end,
          { description = "decrease master width factor", group = "layout" }
      ),
      awful.key({ modkey, "Shift" }, "h",
          function()
            awful.tag.incnmaster(1, nil, true)
          end,
          { description = "increase the number of master clients", group = "layout" }
      ),
      awful.key({ modkey, "Shift" }, "l",
          function()
            awful.tag.incnmaster(-1, nil, true)
          end,
          { description = "decrease the number of master clients", group = "layout" }
      ),
      awful.key({ modkey, "Control" }, "h",
          function()
            awful.tag.incncol(1, nil, true)
          end,
          { description = "increase the number of columns", group = "layout" }
      ),
      awful.key({ modkey, "Control" }, "l",
          function()
            awful.tag.incncol(-1, nil, true)
          end,
          { description = "decrease the number of columns", group = "layout" }
      ),
      awful.key({ modkey }, "space",
          function()
            awful.layout.inc(1)
          end,
          { description = "select next", group = "layout" }
      ),
      awful.key({ modkey, "Shift" }, "space",
          function()
            awful.layout.inc(-1)
          end,
          { description = "select previous", group = "layout" }
      ),
      awful.key({ modkey, "Control" }, "n",
          function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
              c:emit_signal("request::activate", "key.unminimize", { raise = true })
            end
          end,
          { description = "restore minimized", group = "client" }
      ),
  -- Prompt
      awful.key({ modkey }, "p",
          function()
            awful.screen.focused().mainbar.visible = true
            awful.screen.focused().mypromptbox:run()
          end,
          { description = "run prompt", group = "launcher" }
      ),
      awful.key({ modkey, "Shift" }, "p",
          function()
            awful.prompt.run {
              prompt = "Run Lua code: ",
              textbox = awful.screen.focused().mypromptbox.widget,
              exe_callback = awful.util.eval,
              history_path = awful.util.get_cache_dir() .. "/history_eval"
            }
          end,
          { description = "lua execute prompt", group = "awesome" }
      ),

  -- Menubar
      -- awful.key({ modkey }, "a",
      --     function()
      --       menubar.show()
      --     end,
      --     { description = "show the menubar", group = "launcher" }
      -- ),
      awful.key({ modkey}, "a",
          function()
            awful.spawn.raise_or_spawn("rofi -show")
          end,
          { description = "run app finder", group = "launcher" }
      ),

      awful.key {
        modifiers = { modkey },
        keygroup = "numrow",
        description = "only view tag",
        group = "tag",
        on_press = function(index)
          local screen = awful.screen.focused()
          local tag = screen.tags[index]
          if tag then
            tag:view_only()
          end
        end,
      },
      awful.key {
        modifiers = { modkey, "Control" },
        keygroup = "numrow",
        description = "toggle tag",
        group = "tag",
        on_press = function(index)
          local screen = awful.screen.focused()
          local tag = screen.tags[index]
          if tag then
            awful.tag.viewtoggle(tag)
          end
        end,
      },
      awful.key {
        modifiers = { modkey, "Shift" },
        keygroup = "numrow",
        description = "move focused client to tag",
        group = "tag",
        on_press = function(index)
          if client.focus then
            local tag = client.focus.screen.tags[index]
            if tag then
              client.focus:move_to_tag(tag)
            end
          end
        end,
      },
      awful.key {
        modifiers = { modkey, "Control", "Shift" },
        keygroup = "numrow",
        description = "toggle focused client on tag",
        group = "tag",
        on_press = function(index)
          if client.focus then
            local tag = client.focus.screen.tags[index]
            if tag then
              client.focus:toggle_tag(tag)
            end
          end
        end,
      },
      awful.key {
        modifiers = { modkey }, keygroup = "numpad",
        description = "select layout directly",
        group = "layout",
        on_press = function(index)
          local t = awful.screen.focused().selected_tag
          if t then
            t.layout = t.layouts[index] or t.layout
          end
        end,
      }

  )

  if RC.properties.applications then
    for i = 1, #RC.properties.applications do
      local app = RC.properties.applications[i]
      globalkeys = gears.table.join(globalkeys,
          awful.key(app.modifiers, app.key,
          function()
            awful.spawn(app.launch)
          end,
          { description = app.description, group = "custom" })
      )
    end
  end
  return globalkeys
end


return setmetatable(
    {},
    {
      __call = function(_, ...)
        return _M.get(...)
      end
    }
)
