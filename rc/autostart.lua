--------------------------------------------------------------------------------
-- Autostart rules
--------------------------------------------------------------------------------

-- The default path for startup scripts.
start_wrappers = "~/.config/awesome/rc/start_wrappers/"

-- -- The applications that need to be started at awesome launch
-- awful.util.spawn_with_shell(start_wrappers .. "nm-applet")
-- naughty.notify({
--         preset = naughty.config.presets.low,
--         title = "Started application",
--         text = "nm-applet"
-- })

awful.util.spawn_with_shell(start_wrappers .. 'xscreensaver')
awful.util.spawn_with_shell(start_wrappers .. 'xflux')
awful.util.spawn_with_shell(start_wrappers .. 'hamster')
awful.util.spawn_with_shell(start_wrappers .. 'wicd')

-- Start ssh tunnels and irssi client when ready
awful.util.spawn_with_shell(start_wrappers .. 'ssh_tunnel')

-- Start thunderbird client
awful.util.spawn_with_shell(start_wrappers .. 'thunderbird')

-- Start firefox
awful.util.spawn_with_shell(start_wrappers .. 'firefox')

-- Start keepassx client
awful.util.spawn_with_shell(start_wrappers .. 'keepassx')

-- Start irssi tunnel multiplex session
awful.util.spawn_with_shell('sleep 2; ' .. start_wrappers .. 'irssi')

