--------------------------------------------------------------------------------
-- Create widgets
--------------------------------------------------------------------------------

-- Textclock widget
clockicon = wibox.widget.imagebox()
clockicon:set_image(beautiful.widget_clock)
mytextclock = awful.widget.textclock('<span font="Dejavu Sans Mono 8"> %a %d %b  %H:%M</span>')

-- Calendar attached to the textclock
local os = os
local string = string
local table = table
local util = awful.util

char_width = nil
text_color = theme.fg_normal or "#FFFFFF"
today_color = theme.tasklist_fg_focus or "#FF7100"
calendar_width = 21

local calendar = nil
local offset = 0

local data = nil

local function pop_spaces(s1, s2, maxsize)
        local sps = ""
        for i = 1, maxsize - string.len(s1) - string.len(s2) do
                sps = sps .. " "
        end
        return s1 .. sps .. s2
end

local function create_calendar()
        offset = offset or 0

        local now = os.date("*t")
        local cal_month = now.month + offset
        local cal_year = now.year
        if cal_month > 12 then
                cal_month = (cal_month % 12)
                cal_year = cal_year + 1
        elseif cal_month < 1 then
                cal_month = (cal_month + 12)
                cal_year = cal_year - 1
        end

        local last_day = os.date("%d", os.time({ day = 1, year = cal_year,
        month = cal_month + 1}) - 86400)
        local first_day = os.time({ day = 1, month = cal_month, year = cal_year})
        local first_day_in_week =
        os.date("%w", first_day)
        local result = "do lu ma me gi ve sa\n"
        for i = 1, first_day_in_week do
                result = result .. "   "
        end

        local this_month = false
        for day = 1, last_day do
                local last_in_week = (day + first_day_in_week) % 7 == 0
                local day_str = pop_spaces("", day, 2) .. (last_in_week and "" or " ")
                if cal_month == now.month and cal_year == now.year and day == now.day then
                        this_month = true
                        result = result ..
                        string.format('<span weight="bold" foreground = "%s">%s</span>',
                        today_color, day_str)
                else
                        result = result .. day_str
                end
                if last_in_week and day ~= last_day then
                        result = result .. "\n"
                end
        end

        local header
        if this_month then
                header = os.date("%a, %d %b %Y")
        else
                header = os.date("%B %Y", first_day)
        end
        return header, string.format('<span font="%s" foreground="%s">%s</span>',
        theme.font, text_color, result)
end

local function calculate_char_width()
        return beautiful.get_font_height(theme.font) * 0.555
end

function hide()
        if calendar ~= nil then
                naughty.destroy(calendar)
                calendar = nil
                offset = 0
        end
end

function show(inc_offset)
        inc_offset = inc_offset or 0

        local save_offset = offset
        hide()
        offset = save_offset + inc_offset

        local char_width = char_width or calculate_char_width()
        local header, cal_text = create_calendar()
        calendar = naughty.notify({ title = header,
        text = cal_text,
        timeout = 0, hover_timeout = 0.5,
})
end

mytextclock:connect_signal("mouse::enter", function() show(0) end)
mytextclock:connect_signal("mouse::leave", hide)
mytextclock:buttons(util.table.join( awful.button({ }, 1, function() show(-1) end),
awful.button({ }, 3, function() show(1) end)))

local infos = nil

function remove_info()
        if infos ~= nil then
                naughty.destroy(infos)
                infos = nil
        end
end

function add_info()
        remove_info()
        local capi = {
                mouse = mouse,
                screen = screen
        }
        local cal = awful.util.pread(scriptdir .. "dfs")
        cal = string.gsub(cal, "          ^%s*(.-)%s*$", "%1")
        infos = naughty.notify({
                text = string.format('<span font_desc="%s">%s</span>', 'Dejavu Sans Mono', cal),
                timeout = 0,
                position = "top_right",
                margin = 10,
                height = 170,
                width = 585,
                screen	= capi.mouse.screen
        })
end


-- Battery widget
baticon = wibox.widget.imagebox()
baticon:set_image(beautiful.widget_battery)

function batstate()

        local file = io.open('/sys/class/power_supply/BAT0/status', 'r')

        if (file == nil) then
                return 'Cable plugged'
        end

        local batstate = file:read('*line')
        file:close()

        if (batstate == 'Discharging' or batstate == 'Charging') then
                return batstate
        else
                return 'Fully charged'
        end
end

batwidget = wibox.widget.textbox()
vicious.register(batwidget, vicious.widgets.bat,
function (widget, args)
        -- plugged
        if (batstate() == 'Cable plugged') then
                baticon:set_image(beautiful.widget_ac)
                return '<span font="Dejavu Sans Mono 8">AC </span>'
                -- critical
        elseif (args[2] <= 5 and batstate() == 'Discharging') then
                baticon:set_image(beautiful.widget_battery_empty)
                naughty.notify({
                        text = "Battery will run out of power soon.",
                        title = "Battery level: Critical",
                        position = "top_right",
                        timeout = 1,
                        fg="#000000",
                        bg="#ffffff",
                        screen = 1,
                        ontop = true,
                })
                -- low
        elseif (args[2] <= 10 and batstate() == 'Discharging') then
                baticon:set_image(beautiful.widget_battery_low)
                naughty.notify({
                        text = "Battery is running low.",
                        title = "Battery level: Low",
                        position = "top_right",
                        timeout = 1,
                        fg="#ffffff",
                        bg="#262729",
                        screen = 1,
                        ontop = true,
                })
        else baticon:set_image(beautiful.widget_battery)
        end
        return '<span font="Dejavu Sans Mono 8">' .. args[2] .. '% </span>'
end, 1, 'BAT0')

-- Volume widget
volicon = wibox.widget.imagebox()
volicon:set_image(beautiful.widget_vol)
volumewidget = wibox.widget.textbox()
vicious.register(volumewidget, vicious.widgets.volume,
function (widget, args)
        if (args[2] ~= "♩" ) then
                if (args[1] == 0) then volicon:set_image(beautiful.widget_vol_no)
                elseif (args[1] <= 50) then  volicon:set_image(beautiful.widget_vol_low)
                else volicon:set_image(beautiful.widget_vol)
                end
        else volicon:set_image(beautiful.widget_vol_mute)
        end

        return '<span font="Dejavu Sans Mono 8">' .. args[1] .. '% </span>'
end, 1, "Master")

-- Separators
spr = wibox.widget.textbox(' | ')
arrl = wibox.widget.imagebox()
arrl:set_image(beautiful.arrl)
arrl_dl = wibox.widget.imagebox()
arrl_dl:set_image(beautiful.arrl_dl)
arrl_ld = wibox.widget.imagebox()
arrl_ld:set_image(beautiful.arrl_ld)
