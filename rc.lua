---[[                                          ]]--
--                                               --
--                   Based on:                   --
--    Powearrow Darker Awesome WM 3.5.+ config   --
--           github.com/copycat-killer           --
--                                               --
--[[                                           ]]--

-- Localization
os.setlocale(os.getenv("LANG"))

-- Include the required libraties
require('rc.required_libraries')

-- Include the autostart script
require('rc.autostart')

-- Include error Handling
require('rc.error_handling')

-- Include variables
require('rc.variable_definitions')

-- Include wallpaper configuration
require('rc.wallpaper')

-- Include tags configuration
require('rc.tags')

-- Include widgets
require('rc.widgets')

-- {{{ Layout

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
awful.button({ }, 1, awful.tag.viewonly),
awful.button({ modkey }, 1, awful.client.movetotag),
awful.button({ }, 3, awful.tag.viewtoggle),
awful.button({ modkey }, 3, awful.client.toggletag),
awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
)
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
awful.button({ }, 1, function (c)
        if c == client.focus then
                c.minimized = true
        else
                -- Without this, the following
                -- :isvisible() makes no sense
                c.minimized = false
                if not c:isvisible() then
                        awful.tag.viewonly(c:tags()[1])
                end
                -- This will also un-minimize
                -- the client, if needed
                client.focus = c
                c:raise()
        end
end))

for s = 1, screen.count() do

        -- Create a promptbox for each screen
        mypromptbox[s] = awful.widget.prompt()

        -- We need one layoutbox per screen.
        mylayoutbox[s] = awful.widget.layoutbox(s)
        mylayoutbox[s]:buttons(awful.util.table.join(
        awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
        awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
        awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
        awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))

        -- Create a taglist widget
        mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

        -- Create a tasklist widget
        mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

        -- Create the upper wibox
        mywibox[s] = awful.wibox({ position = "top", screen = s, height = 18 })

        -- Widgets that are aligned to the upper left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(spr)
        left_layout:add(mytaglist[s])
        left_layout:add(mypromptbox[s])
        left_layout:add(spr)

        -- Widgets that are aligned to the upper right
        local right_layout = wibox.layout.fixed.horizontal()
        if s == 1 then right_layout:add(wibox.widget.systray()) end
        right_layout:add(spr)
        right_layout:add(volicon)
        right_layout:add(volumewidget)
        right_layout:add(spr)
        right_layout:add(memicon)
        right_layout:add(memwidget)
        right_layout:add(spr)
        right_layout:add(cpuicon)
        right_layout:add(cpuwidget)
        right_layout:add(spr)
        right_layout:add(tempicon)
        right_layout:add(tempwidget)
        right_layout:add(spr)
        right_layout:add(baticon)
        right_layout:add(batwidget)
        right_layout:add(spr)
        right_layout:add(mytextclock)
        right_layout:add(spr)
        right_layout:add(arrl_ld)
        right_layout:add(mylayoutbox[s])

        -- Now bring it all together (with the tasklist in the middle)
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_middle(mytasklist[s])
        layout:set_right(right_layout)
        mywibox[s]:set_widget(layout)

end

-- }}}

-- Include key-bindings file
require('rc.keys')

-- Include rules
require('rc.rules')

-- Include signals
require('rc.signals')
