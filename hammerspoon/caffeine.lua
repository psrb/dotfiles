--- Enabling/disabling caffeine and saving state across reloads.
--- MenuBar item is only visible when active. A click on the item will disable
--- caffeine. Enabling is done via hotkey.

local isEnabledKey = "io.psrb.caffeine.isEnabled"
local caffeineMenuItem = hs.menubar.new()

function toggleCaffeine()
  isEnabled = hs.caffeinate.toggle("displayIdle")
  hs.settings.set(isEnabledKey, isEnabled)

  if isEnabled then
    caffeineMenuItem:returnToMenuBar()
  else
    caffeineMenuItem:removeFromMenuBar()
  end
end

if caffeineMenuItem then
  caffeineMenuItem:setTitle("♨︎")
  caffeineMenuItem:setTooltip("Caffeinate")
  caffeineMenuItem:setClickCallback(toggleCaffeine)
  caffeineMenuItem:removeFromMenuBar()

  if hs.settings.get(isEnabledKey) then
    toggleCaffeine()
  end
end

