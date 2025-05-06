-- This file must be saved as ~/.hammerspoon/init.lua

-- @todo Figure out local vs work configs here, how to make different.
-- local apps = {
--   {modifiers = {"command", "ctrl"}, key = "d", appName = 'docker desktop', appPath = "/Applications/Docker.app"},
--   {modifiers = {"command", "ctrl"}, key = "f", appName = 'finder', appPath = "/System/Library/CoreServices/Finder.app"},
--   {modifiers = {"command", "ctrl"}, key = "i", appName = 'intellij idea', appPath = "/Applications/IntelliJ IDEA.app"},
--   {modifiers = {"command", "ctrl"}, key = "k", appName = 'slack', appPath = "/Applications/Slack.app"},
--   {modifiers = {"command", "ctrl"}, key = "l", appName = 'alacritty', appPath = "/Applications/Alacritty.app"},
--   {modifiers = {"command", "ctrl"}, key = "m", appName = 'chrome', appPath = "/Applications/Google Chrome.app"},
--   {modifiers = {"command", "ctrl"}, key = "n", appName = 'evernote', appPath = "/Applications/Evernote.app"},
--   {modifiers = {"command", "ctrl"}, key = "o", appName = 'zoom', appPath = "/Applications/zoom.us.app"},
--   {modifiers = {"command", "ctrl"}, key = "v", appName = 'preview', appPath = "/Applications/Preview.app"},
--   {modifiers = {"command", "ctrl"}, key = "p", appName = 'spotify', appPath = "/Applications/Spotify.app"},
--   {modifiers = {"command", "ctrl"}, key = "s", appName = 'mongodb compass', appPath = "/Applications/MongoDB Compass.app"},
--   {modifiers = {"command", "ctrl"}, key = "u", appName = 'tuple', appPath = "/Applications/Tuple.app"}
-- }


local hotkeyConfigs = {
  {modifiers = {"command", "ctrl"}, key = "b", apps = {
      {appName = 'xcode_16.3.0_16e140_fb', appPath = "/Applications/Xcode_16.3.0_16E140_fb.app"}
    }
  },
  {modifiers = {"command", "ctrl"}, key = "f", apps = {
      {appName = 'finder', appPath = "/System/Library/CoreServices/Finder.app"}
    }
  },
  {modifiers = {"command", "ctrl"}, key = "h", apps = {
      {appName = 'workchat', appPath = "/Users/carlwiedemann/Applications/Chrome Apps.localized/Workchat.app"},
      {appName = 'whatsapp', appPath = "/Applications/WhatsApp Native.app"}
    }
  },
  {modifiers = {"command", "ctrl"}, key = "i", apps = {
      {appName = 'clion', appPath = "/Applications/CLion.app"}
    }
  },
  {modifiers = {"command", "ctrl"}, key = "j", apps = {
      {appName = 'workchat', appPath = "/Users/carlwiedemann/Applications/Chrome Apps.localized/Workchat.app"},
    }
  },
  {modifiers = {"command", "ctrl"}, key = "k", apps = {
      {appName = 'whatsapp', appPath = "/Applications/WhatsApp Native.app"}
    }
  },
  {modifiers = {"command", "ctrl"}, key = "l", apps = {
      {appName = 'alacritty', appPath = "/Applications/Alacritty.app"}
    }
  },
  {modifiers = {"command", "ctrl"}, key = "m", apps = {
      {appName = 'chrome', appPath = "/Applications/Google Chrome.app"}
    }
  },
  {modifiers = {"command", "ctrl"}, key = "o", apps = {
      {appName = 'zoom', appPath = "/Applications/zoom.us.app"}
    }
  },
  {modifiers = {"command", "ctrl"}, key = "s", apps = {
      {appName = 'simulator', appPath = "/Applications/Xcode_16.3.0_16E140_fb.app/Contents/Developer/Applications/Simulator.app"}
    }
  },
  {modifiers = {"command", "ctrl"}, key = ",", apps = {
      {appName = 'intellij idea', appPath = "/Applications/IntelliJ IDEA.app"}
    }
  },
}

for _, hotkeyConfig in ipairs(hotkeyConfigs) do
  hs.hotkey.bind(hotkeyConfig.modifiers, hotkeyConfig.key, function()
    for _, appDetails in ipairs(hotkeyConfig.apps) do
      local app = hs.application.find(appDetails.appName)
      if app then
        app:setFrontmost(true)
      end
      hs.application.launchOrFocus(appDetails.appPath)
    end
  end)
end

-- Send esc `ctrl + return`
hs.hotkey.bind({"control"}, "return", function()
  hs.eventtap.keyStroke({}, "escape")
end)

-- Send ` using `option + '`
-- Send ~ using `shift + option + '`
hs.hotkey.bind({"option"}, "'", function()
  hs.eventtap.keyStroke({}, "`")
end)

hs.hotkey.bind({"shift", "option"}, "'", function()
  hs.eventtap.keyStroke({"shift"}, "`")
end)

