local _modkey = "Mod4"

local _app = {
  {
    modifiers = { _modkey }, key = "F5",
    launch = { "gtk-launch", "waterfox-g3.desktop" },
    description = "Open Waterfox",
  },
  {
    modifiers = { _modkey }, key = "F6",
    launch = { "gtk-launch", "firefox-developer-edition.desktop" },
    description = "Open Firefox Developer Edition",
  },
  {
    modifiers = { _modkey, "Shift" }, key = "F6",
    launch = { "gtk-launch", "chromium.desktop" },
    description = "Open Chromium",
  },
  {
    modifiers = { _modkey }, key = "F8",
    launch = { "gtk-launch", "visual-studio-code.desktop" },
    description = "Open VS Code",
  },
  {
    modifiers = { _modkey }, key = "F9",
    launch = { "gtk-launch", "jetbrains-idea.desktop" },
    description = "Open IntelliJ Ultimate",
  },
  {
    modifiers = { _modkey, "Shift" }, key = "F9",
    launch = { "gtk-launch", "jetbrains-idea-ce.desktop" },
    description = "Open IntelliJ Community",
  },
  {
    modifiers = { _modkey }, key = "F10",
    launch = { "gtk-launch", "jetbrains-webstorm.desktop" },
    description = "Open WebStorm",
  },
  {
    modifiers = { _modkey }, key = "F11",
    launch = { "gtk-launch", "io.dbeaver.DBeaver.desktop" },
    description = "Open DBeaver Community",
  },
  {
    modifiers = { _modkey, "Shift" }, key = "F11",
    launch = { "gtk-launch", "postman.desktop" },
    description = "Open Postman",
  },
  {
    modifiers = { }, key = "Print",
    launch = { "flameshot", "gui" },
    description = "Capture area",
  },
}

local _props = {
  terminal = "kitty",
  editor = "nvim",
  modkey = "Mod4",
  theme_name = "minez-top",
  --titlebar_font = "Noto Sans Display Medium 10",
  applications = _app,
  default_wallpaper = '/shared/Pictures/current-wallpaper.png'
}

return _props
