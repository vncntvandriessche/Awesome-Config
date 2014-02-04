--------------------------------------------------------------------------------
---- Define wallpaper settings
----------------------------------------------------------------------------------

-- Maximize wallpaper at every screen
if not beautiful.wallpaper then
        return
end

for s = 1, screen.count() do
    gears.wallpaper.maximized( beautiful.wallpaper, s, true )
end
