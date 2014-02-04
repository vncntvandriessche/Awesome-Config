--------------------------------------------------------------------------------
-- Autostart rules
--------------------------------------------------------------------------------

function start_application ( script, show, name )

        -- The default path for startup scripts.
        -- TODO: Get this from a centralized configuration file
        start_wrappers = "~/.config/awesome/rc/start_wrappers/"

        show = show or true
        name = name or string.gsub( script, start_wrappers, '' )

        awful.util.spawn_with_shell( script )

        if show == false then
                return
        end

        naughty.notify({
                preset = naughty.config.presets.low,
                title = "Started application",
                text = name,
        })
end

-- -- The applications that need to be started at awesome launch
start_application( start_wrappers .. 'xscreensaver' )
start_application( start_wrappers .. 'xflux' )
start_application( start_wrappers .. 'hamster' )
start_application( start_wrappers .. 'wicd' )

-- Start ssh tunnels and irssi client when ready
start_application( start_wrappers .. 'ssh_tunnel' )

-- Start thunderbird client
start_application( start_wrappers .. 'thunderbird' )

-- Start firefox
start_application( start_wrappers .. 'firefox' )

-- Start keepassx client
start_application( start_wrappers .. 'keepassx' )

-- Start irssi tunnel multiplex session
start_application( 'sleep 2; ' .. start_wrappers .. 'irssi', false, 'Ssh tunnels' )
