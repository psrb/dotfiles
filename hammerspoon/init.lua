require "caffeine"
require "windowHandling"
require "utility/blackout"

local terminal = require "appHelper/terminal"
local macvim = require "appHelper/macvim"

local bind = hs.hotkey.bind
local mash = {"cmd", "alt", "ctrl"}
local hyper = {"cmd", "alt", "ctrl", "shift"}

--------------------------------------------------------------------------------
-- General utilities
--------------------------------------------------------------------------------

--- Reload hammerspoon config
bind(mash, "R", hs.reload)

--- Caffeine
bind(mash, "C", toggleCaffeine)

--- Blackout screen
bind(mash, "B", toggleScreenBlackout)

--------------------------------------------------------------------------------
-- Window management and focus switching
--------------------------------------------------------------------------------

--- Move a windows position
--- Uses the resting position of the left hand as a grid.
---
---  U I O
--- H J K L
---    M , .
---
bind(mash, "M", moveFocusedWindowToLowerLeftCorner)
bind(mash, "J", moveFocusedWindowToLeftHalf)
bind(mash, "U", moveFocusedWindowToUpperLeftCorner)
bind(mash, "I", moveFocusedWindowToTopHalf)

bind(mash, "H", moveFocusedWindowToFullscreen)
bind(mash, "K", moveFocusedWindowToCenter)

bind(mash, "O", moveFocusedWindowToUpperRightCorner)
bind(mash, "L", moveFocusedWindowToRightHalf)
bind(mash, ".", moveFocusedWindowToLowerRightCorner)
bind(mash, ",", moveFocusedWindowToBottomHalf)

bind(mash, "P", moveFocusedWindowToNextScreen)

-- FIXME There seems to be a problem in OSX (?) when focussing one window of an
-- app which has at least two windows on different screens visible.  The window
-- on the current screen will be focused even though the window on the other
-- screen should be focused.
--
-- HS issues:
--   - https://github.com/Hammerspoon/hammerspoon/issues/304
--   - https://github.com/Hammerspoon/hammerspoon/issues/370

--- Move focus between windows across all visible screens.
local wFilterSpace = hs.window.filter.new(nil, "wFilterSpace")
wFilterSpace:setCurrentSpace(true):setDefaultFilter()

bind(hyper, "H", function() wFilterSpace:focusWindowWest( nil, true, true) end)
bind(hyper, "J", function() wFilterSpace:focusWindowSouth(nil, true, true) end)
bind(hyper, "K", function() wFilterSpace:focusWindowNorth(nil, true, true) end)
bind(hyper, "L", function() wFilterSpace:focusWindowEast( nil, true, true) end)

--- Show window hints. Allows for quick selection of any visible window letters
bind(mash, "Y", hs.hints.windowHints)

--------------------------------------------------------------------------------
-- Opening and focussing apps
--------------------------------------------------------------------------------

--- Create a new Terminal window
bind(mash, "T", terminal.launchOrNewWindow)
--- Create a new Terminal window in working directory of frontmost app
bind(hyper, "T", terminal.newWindowForFrontmostApp)

--- Create a new MacVim window
bind(mash, "V", macvim.launchOrNewWindow)
--- Display chooser containing options to open file/directory of frontmost app
--- or specific sessions
bind(hyper, "V", macvim.openDialog)

--- Dash
bind(mash, "D", function() hs.application.launchOrFocus("Dash") end)

