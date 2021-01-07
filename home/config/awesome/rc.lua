-- awesome_mode: api-level=4:screen=on
pcall(require, "luarocks.loader")

local awful = require("awful")
local gears = require("gears")
local menubar = require("menubar")
local naughty = require("naughty")
local utils = require("lib.utils")

local skip_autostarts = os.getenv("AWESOME_SKIP_AUTOSTARTS")
local log_level = os.getenv("LOG_LEVEL")

RC = {}
RC.functions = {}
RC.properties = require("config.properties")

log = utils.log

if log_level then
  log.level(log_level)
end

modkey = RC.properties.modkey
terminal = RC.properties.terminal
editor = RC.properties.editor
editor_cmd = RC.properties.editor_cmd or terminal .. ' -e ' .. editor

local desktop = require("lib.desktop")
desktop.init()

require("awful.hotkeys_popup.keys")
require("config.error-handling")
require("config.signals")

awful.rules.rules = require("config.rules")()
naughty.config.defaults.position = "bottom_right"

RC.menu_items = require("config.menu")()

RC.bindings = {
  globalbuttons = require("config.bindings.globalbuttons")(),
  clientbuttons = require("config.bindings.clientbuttons")(),
  globalkeys = require("config.bindings.globalkeys")(),
  clientkeys = require("config.bindings.clientkeys")(),
}
root.buttons(RC.bindings.globalbuttons)
root.keys(RC.bindings.globalkeys)

RC.theme_path = gears.filesystem.get_configuration_dir() .. "themes/" .. RC.properties.theme_name .. "/"
local theme_module_path = "themes." .. RC.properties.theme_name .. "."

local theme = dofile(RC.theme_path .. "theme.lua")

theme.init()

menubar.utils.terminal = terminal -- Set the terminal for applications that require it

if (skip_autostarts == nil) then
  utils.run_apps_in(gears.filesystem.get_configuration_dir() .. "autostart.d/")
  utils.run_apps_in(RC.theme_path .. "autorun.d/")
end
