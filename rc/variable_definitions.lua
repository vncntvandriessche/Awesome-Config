--------------------------------------------------------------------------------
-- Variable definitions
--------------------------------------------------------------------------------

-- Useful Paths
home         = os.getenv("HOME")
confdir      = home .. "/.config/awesome"
scriptdir    = confdir .. "/scripts/"
themes       = confdir .. "/themes"
active_theme = themes .. "/powerarrow-darker"

-- Define theme
beautiful.init(active_theme .. "/theme.lua")

terminal               = "terminator"
browser                = "firefox"
mail                   = "thunderbird"
menubar.utils.terminal = terminal

-- Default modkey.
modkey = "Mod4"
altkey = "Mod1"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
    --awful.layout.suit.magnifier
}
