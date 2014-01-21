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

-- Include layout stuff
require('rc.layout')

-- Include key-bindings file
require('rc.keys')

-- Include rules
require('rc.rules')

-- Include signals
require('rc.signals')
