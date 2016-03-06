--- Overlays a black rectangle on the current screen.
--- Useful for watching videos on one screen without getting distracted by the
--- stuff on the other screen.
---
--- Can be dismissed by clicking on it.

local blackoutRect = nil

local function deleteBlackoutRectangle()
  blackoutRect:delete()
  blackoutRect = nil
end

local function createBlackoutRectangle()
  screen = hs.screen.mainScreen()
  blackoutRect = hs.drawing.rectangle(screen:fullFrame())
  blackoutRect:setFillColor({0, 0, 0, 1})
  blackoutRect:setFill(true)
  -- don't activate other hs windows on click
  blackoutRect:clickCallbackActivating(false)
  blackoutRect:setClickCallback(nil, deleteBlackoutRectangle)
  blackoutRect:show()
end

function toggleScreenBlackout()
  if blackoutRect then
    deleteBlackoutRectangle()
  else
    createBlackoutRectangle()
  end
end

