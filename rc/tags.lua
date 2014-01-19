--------------------------------------------------------------------------------
-- Define tags
--------------------------------------------------------------------------------

-- Define a tag table which hold all screen tags.
tags = {
        names  = { "Chat",     "Passw",    "Mail",     "Browse",   "5",        "6",        "7" },
        layout = { layouts[6], layouts[4], layouts[3], layouts[6], layouts[6], layouts[6], layouts[6] }
}

-- Assign same tag table to all screens.
for s = 1, screen.count() do
        -- Each screen has its own tag table.
        tags[s] = awful.tag(tags.names, s, tags.layout)
end
