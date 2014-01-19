--------------------------------------------------------------------------------
-- Define the rules
--------------------------------------------------------------------------------

awful.rules.rules = {

        -- All clients will match this rule.
        { rule = { },
                properties = { border_width = beautiful.border_width,
                        border_color = beautiful.border_normal,
                        focus = true,
                        keys = clientkeys,
                        buttons = clientbuttons,
                        size_hints_honor = false
                }
        },

        { rule = { class = "MPlayer" },
                properties = { floating = true }
        },

        { rule = { class = "Plugin-container"},
                properties = { floating = true }
        },

        { rule = { class = "irssi"},
                properties = { tag = tags[1][1] }
        },

        { rule = { class = "Keepassx" },
                properties = { tag = tags[1][2] }
        },

        { rule = { class = "Thunderbird" },
                properties = { tag = tags[1][3] }
        },

        { rule = { class = "Firefox" },
                properties = { tag = tags[1][4] }
        },

}
