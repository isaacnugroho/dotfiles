local home = os.getenv("HOME")

local _app = {
  {
    modifiers = { }, key = "XF86Mail",
    launch = { "gtk-launch", "code-oss.desktop" },
    description = "Open VS Code",
  },
  {
    modifiers = { }, key = "XF86HomePage",
    launch = { "gtk-launch", "waterfox-g3.desktop" },
    description = "Open browser",
  },
  {
    modifiers = { "Mod1" }, key = "XF86HomePage",
    launch = "waterfox-g3 --private-window",
  },
  {
    modifiers = { }, key = "XF86Explorer",
    launch = { "gtk-launch", "jetbrains-idea.desktop" },
    description = "IntelliJ Ultimate",
  },
  {
    modifiers = { "Mod1" }, key = "XF86Explorer",
    launch = { "gtk-launch", "jetbrains-idea-ce.desktop" },
    description = "IntelliJ Community",
  },
}

local _props = {
  terminal = "kitty",
  editor = "nvim",
  modkey = "Mod4",
  theme_name = "minez",
  --titlebar_font = "Noto Sans Display Medium 10",
  applications = _app,
  default_wallpaper = '/shared/Pictures/current-wallpaper.png'
}

return _props
