--------------------------------------------------------------------------------
-- Autostart rules
--------------------------------------------------------------------------------

-- The run_once function
function run_once(cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
     findme = cmd:sub(0, firstspace-1)
  end
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
end

-- -- The applications that need to be started at awesome launch
-- run_once("pidgin")
-- run_once("hamster")
-- run_once("xscreensaver")
-- run_once("~/Documents/snippets/start_flux")
