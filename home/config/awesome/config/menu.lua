-- Standard awesome library
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local archmenu = require("config/archmenu")

local _M = {} -- module

function _M.get()

  return {
    { 
      "Applications", xdgmenu 
    },
    {
      "Show hotkeys",
      function()
        hotkeys_popup.show_help(nil, awful.screen.focused())
      end
    },
    { 
      "View manual", 
      terminal .. " -e man awesome" 
    },
    { 
      "Edit config", 
      editor_cmd .. " " .. awesome.conffile 
    },
    { 
      "Restart", 
      awesome.restart 
    },
    { 
      "Terminal",           
      function()
        awful.spawn.raise_or_spawn(terminal .. " -d=~", {
          skip_taskbar = true
        })
      end,
    },
    { 
      "Logout", 
      function() 
        awesome.quit() 
      end 
    },
    { 
      "Reboot", 
      "systemctl reboot" 
    },
    { 
      "Shutdown", 
      "systemctl poweroff" 
    },
  }
end

return setmetatable({}, { __call = function(_, ...)
  return _M.get(...)
end })
