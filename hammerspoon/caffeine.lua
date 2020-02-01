--- Enabling/disabling caffeine and saving state across restarts.
--- MenuBar item is only visible when active. A click on the item will disable
--- caffeine. Enabling is done via hotkey.

local isEnabledKey = "io.psrb.caffeine.isEnabled"
local sleepType = "displayIdle"
local caffeineMenuItem = hs.menubar.new(false)
local logger = hs.logger.new("caffeine", "info")


function toggleCaffeine()
  isEnabled = hs.caffeinate.get(sleepType)
  logger:i("Caffeine is currently " .. (isEnabled and "enabled" or "disabled"))

  if isEnabled then
    logger:i("Disabling caffeine")
    disableCaffeine()
  else
    logger:i("Enabling caffeine")
    enableCaffeine()
  end
end

function enableCaffeine()
  isEnabled = hs.caffeinate.set(sleepType, true)
  hs.settings.set(isEnabledKey, true)

  caffeineMenuItem:returnToMenuBar()
  caffeineMenuItem:setTitle("♨︎")
  caffeineMenuItem:setTooltip("Caffeinate")
  caffeineMenuItem:setClickCallback(toggleCaffeine)
end

function disableCaffeine()
  isEnabled = hs.caffeinate.set(sleepType, false)
  hs.settings.set(isEnabledKey, false)
  caffeineMenuItem:removeFromMenuBar()
end

if caffeineMenuItem then
  logger:i("Restoring caffeine state")
  if hs.settings.get(isEnabledKey) then
    toggleCaffeine()
  end
end
