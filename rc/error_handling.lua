--------------------------------------------------------------------------------
-- Error handling
--------------------------------------------------------------------------------

function prevent_error_loop( err )

        if in_error then
                return
        end
        in_error = true

        naughty.notify({
                preset = naughty.config.presets.critical,
                title = "Oops, an error happened!",
                text = err
        })
        in_error = false

end

-- Check if awesome encountered an error during startup and fall back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
        naughty.notify({
                preset = naughty.config.presets.critical,
                title = "Oops, there were errors during startup!",
                text = awesome.startup_errors
        })
end

-- Handle runtime errors after startup
do
        in_error = false
        awesome.connect_signal( "debug::error", prevent_error_loop )
end

