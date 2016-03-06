--- Functions for moving the currently focused window to a specific position or
--- to other screens.

local positions = {
  LowerLeftCorner  = hs.geometry.rect(0.0, 0.5, 0.5, 0.5),
  LeftHalf         = hs.geometry.rect(0.0, 0.0, 0.5, 1.0),
  UpperLeftCorner  = hs.geometry.rect(0.0, 0.0, 0.5, 0.5),
  TopHalf          = hs.geometry.rect(0.0, 0.0, 1.0, 0.5),

  LowerRightCorner = hs.geometry.rect(0.5, 0.5, 0.5, 0.5),
  RightHalf        = hs.geometry.rect(0.5, 0.0, 0.5, 1.0),
  UpperRightCorner = hs.geometry.rect(0.5, 0.0, 0.5, 0.5),
  BottomHalf       = hs.geometry.rect(0.0, 0.5, 1.0, 0.5),

  Center           = hs.geometry.rect(0.1, 0.0, 0.8, 1.0),
  Fullscreen       = hs.geometry.rect(0.0, 0.0, 1.0, 1.0),
}

--- Disable window animations (only for Hammerspoon)
hs.window.animationDuration = 0

function moveFocusedWindowToNextScreen()
  local window = hs.window.focusedWindow()
  if window then
    window:moveToScreen(window:screen():next())
  end
end

--- moveFocusedWindowTo{positions}
for name, position in pairs(positions) do
  _G["moveFocusedWindowTo"..name] = function()
    local window = hs.window.focusedWindow()
    if window then
      window:move(position)
    end
  end
end

