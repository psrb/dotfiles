--- MacVim helper functions
--- * Creating new windows
--- * Load sessions or open file/directory of frontmost app

require "utility/applescript"

local fn = hs.fnutils
local iterm = require "appHelper/iterm"

local macvim = {}

function macvim.launchOrNewWindow()
  iterm.doCommand([[mvim +\"silent ruby p ''\" && sleep 2 && exit]])
end

--------------------------------------------------------------------------------
-- Open dialog
--------------------------------------------------------------------------------

local function frontmostAppCandidate()
  local appName = hs.application.frontmostApplication():name()

  if appName == "Finder" then
    local path = executeAppleScript([[
      tell application "Finder"
        POSIX path of (folder of first window as text)
      end tell
    ]])

    if not path then
      return nil
    end

    return {
      ["text"] = "Finder",
      ["subText"] = "Directory of the frontmost Finder window",
      ["type"] = "Finder",
      ["path"] = path
    }

  elseif appName == "Xcode" then
    return {
      ["text"] = "Xcode",
      ["subText"] = "Open with external editor",
      ["type"] = "Xcode",
    }
  end
end

local function vimOpenCandidates()

  local choices = { }

  local appChoice = frontmostAppCandidate()
  if appChoice then
    table.insert(choices, appChoice)
  end

  -- Vim Sessions

  -- I am using the plugin: https://github.com/xolox/vim-session
  -- The session files are stored as `SESSION_NAME.vim`. If a session is open it
  -- will be locked indicated by a lock-file named `SESSION_NAME.vim.lock`.
  -- A session can be opened using `:OpenSession SESSION_NAME`.

  local sessionDirectory = os.getenv("HOME") .. "/.vim/sessions"
  local filenameSuffix = ".vim"
  local lockSuffix = filenameSuffix .. ".lock"

  local filesToSkip = {".", "..", "restart.vim"}
  local allSessions = {}
  local lockedSessions = {}
  for filename in hs.fs.dir(sessionDirectory) do
    if not fn.contains(filesToSkip, filename) then
      local lockStart = string.find(filename, lockSuffix, 1, false)
      if lockStart then
        lockedSessions[#lockedSessions+1] = string.sub(filename, 1, lockStart-1)
      else
        local nameLength = string.len(filename)
        allSessions[#allSessions+1] = string.sub(filename, 1, nameLength-4)
      end
    end
  end

  local unlockedSessions = fn.ifilter(allSessions, function(element)
    return not fn.contains(lockedSessions, element)
  end)

  for _, sessionName in ipairs(unlockedSessions) do
    local session = {
      ["text"] = sessionName,
      ["subText"] = "Vim Session",
      ["type"] = "Vim Session",
      ["session"] = sessionName
    }
    table.insert(choices, session)
  end

  for _, lockedSessionName in ipairs(lockedSessions) do
    local session = {
      ["text"] = "Locked: " .. lockedSessionName,
      ["subText"] = "Locked Vim Session",
      ["type"] = "Vim Session",
      ["session"] = sessionName
    }
    table.insert(choices, session)
  end

  return choices
end

local vimOpenChooser = nil

local function chooseComplete(choice)
  if choice["type"] == "Finder" then
    iterm.doCommand(string.format(
      [[cd \"%s\" && mvim +\"silent ruby p ''\" && sleep 2 && exit]],
      choice["path"]))

  elseif choice["type"] == "Xcode" then
    local xcode = hs.application.get("Xcode")
    if xcode then
      xcode:activate() -- Apparently Xcode needs to be focussed
      xcode:selectMenuItem({"File", "Open with External Editor"})
    end

  elseif choice["type"] == "Vim Session" then
    iterm.doCommand(string.format(
      [[mvim +\"silent ruby p ''\" +\"OpenSession %s\" && sleep 2 && exit]],
      choice["session"]))
  end
end

function macvim.openDialog()

  if not vimOpenChooser then
    vimOpenChooser = hs.chooser.new(chooseComplete)
    vimOpenChooser:width(20)
  end
  vimOpenChooser:query("")

  local choices = vimOpenCandidates()
  vimOpenChooser:choices(choices)
  vimOpenChooser:rows(#choices)
  vimOpenChooser:show()
end

return macvim

