require "utility/applescript"

local logger = hs.logger.new("iTerm")

local iterm = {}

function iterm.newWindow()
  executeAppleScript([[
      tell application "iTerm"
        set newWindow to create window with default profile
        select newWindow
      end tell
  ]], "Create new iTerm window")
end

function iterm.doCommand(cmd)
  as = string.format([[
      tell application "iterm"
        set newWindow to create window with default profile
        select newWindow
        write current session of newWindow text "%s"
      end tell
    ]], cmd)

  executeAppleScript(as, "Execute command in new iTerm window")
end

function iterm.launchOrNewWindow()
  local itermApp = hs.application.get("iTerm2")
  if itermApp then
    iterm.newWindow()
  else
    hs.application.launchOrFocus("iTerm2")
  end
end

--- Creates a new iterm window in the current working directory of the
--- frontmost app.
---
--- Works for:
---  - Macvim
---  - Finder
---  - TODO Xcode?
function iterm.newWindowForFrontmostApp()
  local frontmostApp = hs.application.frontmostApplication()

  if frontmostApp:name() == "MacVim" then
    local windowTitle = frontmostApp:focusedWindow():title()
    local _, _, servername = string.find(windowTitle, " - ([%u%d]+)$")

    if servername then
      iterm.doCommand(string.format(
        [[cd \"$(mvim --servername %s --remote-expr \"getcwd()\")\" && clear]],
        servername))
    else
      hs.alert("Failed to match vim server for title: " .. windowTitle)
    end

  elseif frontmostApp:name() == "Finder" then
    cwd = executeAppleScript([[
      tell application "Finder"
        set cwd to POSIX path of (folder of first window as text)
      end tell
    ]], "Get current working directory of Finder")

    if cwd then
      iterm.doCommand(string.format("cd \\\"%s\\\" && clear", cwd))
    end
  end
end

return iterm

