require "utility/applescript"

local safari = {}

function safari.newWindow()
  executeAppleScript([[
      tell application "Safari"
        make new document
      end tell
  ]], "Create new Safari window")
end

return safari
