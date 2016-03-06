--- Enabling/disabling caffeine and saving state across reloads.
--- MenuBar item is only visible when active. A click on the item will disable
--- caffeine. Enabling is done via hotkey.

local settingsKey = "io.psrb.caffeine.isEnabled"
local wasEnabled = hs.settings.get(settingsKey)
local caffeineMenuItem = hs.menubar.new(hs.caffeinate.get("displayIdle"))

function toggleCaffeine()
  isEnabled = hs.caffeinate.toggle("displayIdle")
  hs.settings.set(settingsKey, isEnabled)

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

  if wasEnabled then
    toggleCaffeine()
  end
end

