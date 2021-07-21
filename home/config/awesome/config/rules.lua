local awful = require("awful")

local _M = {}

function _M.get()
  local rules = {

    -- All clients will match this rule.
    {
      id = "global",
      rule = { },
      except_any = {
        type = { "desktop" },
      },
      properties = {
        focus = awful.client.focus.filter,
        floating = true,
        raise = true,
        screen = awful.screen.preferred,
        -- placement = awful.placement.no_overlap + awful.placement.no_offscreen
        placement = awful.placement.no_offscreen
      }
    },

    -- Floating clients.
    {
      id = "floating",
      rule_any = {
        instance = {
          "DTA", -- Firefox addon DownThemAll.
          "copyq", -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin", -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer",
          "Conky",
          "Guake",
        },

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester", -- xev.
        },
        role = {
          "AlarmWindow", -- Thunderbird's calendar.
          "ConfigManager", -- Thunderbird's about:config.
          "pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
        }
      },
      properties = {
        floating = true
      }
    },
    -- {
    --   id = "sticky",
    --   rule = { class = "Xfdesktop" },
    --   properties = {
    --     border_width = 0,
    --     sticky = true,
    --   }
    -- },
    -- Add titlebars to normal clients and dialogs
    {
      id = "titlebar",
      rule_any = {
        type = { "normal", "dialog" }
      },
      except_any = {
        type = { "desktop" },
        class = {
          "Conky",
          "Guake",
          "Shortwave",
        },
      },
      properties = {
        titlebars_enabled = true,
      }
    },
    -- jetbrains
    {
      id = "jetbrains-splash",
      rule = {
        name = "win0"
      },
      properties = {
        titlebars_enabled = false,
        focusable = false,
        focus = true,
        floating = true,
        placement = awful.placement.restore
      }
    },
    -- kitty
    {
      id = "kitty",
      rule = { class = 'kitty' },
      properties = {
        titlebars_enabled = false,
        placement = awful.placement.no_overlap + awful.placement.bottom
      }
    },

  }

  return rules
end

return setmetatable(
    {},
    { __call = function(_, ...)
      return _M.get(...)
    end }
)
