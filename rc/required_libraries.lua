--------------------------------------------------------------------------------
-- Required libraries
--------------------------------------------------------------------------------
gears 	        = require('gears')
awful           = require('awful')
awful.rules     = require('awful.rules')
awful.autofocus = require('awful.autofocus')
wibox           = require('wibox')
beautiful       = require('beautiful')
naughty         = require('naughty')
vicious         = require('vicious')
scratch         = require('scratch')


-- Include the best layout ever
require('vain')

-- Enables the menubar that runs through applications folder
menubar = require('menubar')
