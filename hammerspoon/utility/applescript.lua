local logger = hs.logger.new("AppleScript")

-- Execute the given apple script and logs any errors. The context will be added
-- to the log.
-- Returns: The output of the apple script if successful, nil otherwise
function executeAppleScript(script, context)
  successful, output, errDesc = hs.osascript.applescript(script)

  if not successful then
    msg = string.format("Failed to execute AppleScript (%s)", context)

    hs.alert(msg)
    logger:e(msg)
    logger:e(string.format("Script:\n%s", script))
    logger:e(string.format("Error:\n%s", hs.inspect(errDesc)))
    return nil
  end

  return output
end

