--- Some Terminal helper functions

local logger = hs.logger.new("terminal")

local terminal = {}

-- TODO "do script" gets executed for every new tab...
function terminal.doScript(script)
    successful, output = hs.applescript(string.format([[
      tell application "Terminal"
        do script "%s"
        activate
      end tell
    ]], script))

    if not successful then
      hs.alert("Terminal \"doScript\" failed!")

      logger:e("Terminal \"doScript\" failed!")
      logger:e(script)
      logger:e(hs.inspect(output))
    end
end

function terminal.launchOrNewWindow()
  -- Creating a new window using hs.window.selectMenuItem is rather fragile for
  -- Terminal.app, because the menu item contains the name of the color scheme.
  -- The AppleScript below is more robust.

  local terminalApp = hs.application.get("Terminal")
  if terminalApp then
    terminal.doScript("")
  else
    hs.application.launchOrFocus("Terminal")
  end
end

--- Creates a new terminal window in the current working directory of the
--- frontmost app.
---
--- Works for:
---  - Macvim
---  - Finder
---  - TODO Xcode?
function terminal.newWindowForFrontmostApp()
  local frontmostApp = hs.application.frontmostApplication()

  if frontmostApp:name() == "MacVim" then
    local windowTitle = frontmostApp:focusedWindow():title()
    local _, _, servername = string.find(windowTitle, " - ([%u%d]+)$")

    if servername then
      terminal.doScript(string.format(
        [[cd \"$(mvim --servername %s --remote-expr \"getcwd()\")\" && clear]],
        servername))
    else
      hs.alert("Failed to match vim server for title: " .. windowTitle)
    end

  elseif frontmostApp:name() == "Finder" then
    successful, output = hs.applescript([[
      tell application "Finder"
        set cwd to POSIX path of (folder of first window as text)
      end tell

      tell application "Terminal"
        do script "cd \"" & cwd & "\" && clear"
        activate
      end tell
    ]])

    if not successful then
      hs.alert("Finder CWD AppleScript failed!")

      logger:e("Finder CWD AppleScript failed!")
      logger:e(hs.inspect(output))
    end
  end
end

return terminal

