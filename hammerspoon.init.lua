-- This file must be saved as ~/.hammerspoon/init.lua

-- local log = hs.logger.new("### HS ###","debug")
-- log.i("Initializing")

-- @todo Figure out local vs work configs here, how to make different.
-- ```
--   hostname = hs.host.localizedName()
--   if (hostname == "fuyo" or hostname == "fuyoshi") then
-- ```

----------------------------
-- Launching applications --
----------------------------
local launcherHotkeyConfigs = {
  {key = "f", apps = {
      {appName = "finder", appPath = "/System/Library/CoreServices/Finder.app"}
    }
  },
  {key = "h", apps = {
      {appName = "workchat", appPath = "/Users/carlwiedemann/Applications/Chrome Apps.localized/Workchat.app"},
      {appName = "whatsapp", appPath = "/Applications/WhatsApp Native.app"}
    }
  },
  {key = "i", apps = {
      {appName = "xcode_16.3.0_16e140_fb", appPath = "/Applications/Xcode_16.3.0_16E140_fb.app"},
    }
  },
  {key = "j", apps = {
      {appName = "workchat", appPath = "/Users/carlwiedemann/Applications/Chrome Apps.localized/Workchat.app"},
    }
  },
  {key = "k", apps = {
      {appName = "whatsapp", appPath = "/Applications/WhatsApp Native.app"}
    }
  },
  {key = "l", apps = {
      {appName = "alacritty", appPath = "/Applications/Alacritty.app"}
    }
  },
  {key = "m", apps = {
      {appName = "chrome", appPath = "/Applications/Google Chrome.app"}
    }
  },
  {key = "n", apps = {
      {appName = "notes", appPath = "/System/Applications/Notes.app"}
    }
  },
  {key = "o", apps = {
      {appName = "zoom", appPath = "/Applications/zoom.us.app"}
    }
  },
  {key = "p", apps = {
      {appName = "spotify", appPath = "/Applications/Spotify.app"}
    }
  },
  {key = "s", apps = {
      {appName = "simulator", appPath = "/Applications/Xcode_16.3.0_16E140_fb.app/Contents/Developer/Applications/Simulator.app"}
    }
  },
  {key = ",", apps = {
      {appName = "intellij idea", appPath = "/Applications/IntelliJ IDEA.app"}
    }
  },
  {key = ".", apps = {
      {appName = "clion", appPath = "/Applications/CLion.app"}
    }
  }
}

for _, hotkeyConfig in ipairs(launcherHotkeyConfigs) do
  hs.hotkey.bind({"command", "ctrl"}, hotkeyConfig.key, function()
    for _, appDetails in ipairs(hotkeyConfig.apps) do
      local app = hs.application.find(appDetails.appName, true, true)
      if app then
        app:setFrontmost(true)
      end
      hs.application.launchOrFocus(appDetails.appPath)
    end
  end)
end

---------------------------------------------------------------------------------------------------------------
-- App-based shortcuts based on https://github.com/Hammerspoon/hammerspoon/issues/664#issuecomment-202829038 --
---------------------------------------------------------------------------------------------------------------

-- Make Xcode JetBrains
local sendVimWindowNavigationBack = hs.hotkey.new("control", "h", function()
  hs.eventtap.keyStroke({"control", "shift"}, "l")
end)
local sendVimWindowNavigationUp = hs.hotkey.new("control", "k", function()
  hs.eventtap.keyStroke({"control", "shift"}, "l")
end)
local sendVimWindowNavigationDown = hs.hotkey.new("control", "j", function()
  hs.eventtap.keyStroke({"control"}, "l")
end)
local sendShowMembers = hs.hotkey.new("command", "m", function()
  hs.eventtap.keyStroke({"control"}, "6")
end)
local sendShowRecents = hs.hotkey.new("command", "e", function()
  hs.eventtap.keyStroke({"control"}, "1", 10)
  hs.eventtap.keyStroke(nil, "down", 10)
  hs.eventtap.keyStroke(nil, "right", 10)
  hs.eventtap.keyStroke(nil, "down", 10)
end)
local sendShowObjCCompliment = hs.hotkey.new("command", "h", function()
  hs.eventtap.keyStroke({"control"}, "1", 10)
  hs.eventtap.keyStroke(nil, "down", 10)
  hs.eventtap.keyStroke(nil, "down", 10)
  hs.eventtap.keyStroke(nil, "down", 10)
  hs.eventtap.keyStroke(nil, "right", 10)
  hs.eventtap.keyStroke(nil, "return", 10)
end)

hs.window.filter.new("Xcode")
  :subscribe(hs.window.filter.windowFocused,function()
    sendVimWindowNavigationBack:enable()
    sendVimWindowNavigationDown:enable()
    sendVimWindowNavigationUp:enable()
    sendShowMembers:enable();
    sendShowRecents:enable();
    sendShowObjCCompliment:enable();
  end)
  :subscribe(hs.window.filter.windowUnfocused,function()
    sendVimWindowNavigationBack:disable()
    sendVimWindowNavigationDown:disable()
    sendVimWindowNavigationUp:disable()
    sendShowMembers:disable();
    sendShowRecents:disable();
    sendShowObjCCompliment:disable();
  end)

-- Simulate "Visual Block" mode
local vInsert = false
k = hs.hotkey.modal.new({"control"}, "v")

function k:entered()
  vInsert = false
  if hs.window.frontmostWindow():application():name() == "Xcode" then
    print("-- BEGIN VISUAL BLOCK --")
    hs.eventtap.keyStroke(nil, "v", 2)
  else
    -- Pass through, which is fine because the binding is disabled by default.
    hs.eventtap.keyStroke({"control"}, "v", 1)
    k:exit()
  end
end

function k:exited()
  if hs.window.frontmostWindow():application():name() == "Xcode" then
    print("-- END VISUAL BLOCK --")
    -- If we are exiting on insert, then we don't want to send extra escape events.
    if not vInsert then
      hs.eventtap.keyStroke(nil, "escape", 2)
      hs.eventtap.keyStroke(nil, "escape", 2)
      vInsert = false
    end
  end
end

k:bind(nil, "escape", function()
  k:exit()
end)

k:bind(nil, 'j', nil, function()
    hs.eventtap.keyStroke({"control", "shift"}, "down", 2)
end)

k:bind(nil, 'k', nil, function()
      hs.eventtap.keyStroke({"control", "shift"}, "up", 2)
end)

k:bind({"shift"}, "i", nil, function()
  hs.eventtap.keyStroke(nil, "v", 2)
  hs.eventtap.keyStroke(nil, "v", 2)
  hs.eventtap.keyStroke(nil, "i", 2)
  vInsert = true
  -- Insertion effectively ends the visual selection, so we can exit.
  k:exit()
end)

-- Simple saving for Vim please (via Alacritty).
local sendSave = hs.hotkey.new("command", "s", function()
  hs.eventtap.keyStroke({"shift"}, ";", 2)
  hs.eventtap.keyStroke(nil, "w", 2)
  hs.eventtap.keyStroke(nil, "return", 2)
end)

hs.window.filter.new("Alacritty")
  :subscribe(hs.window.filter.windowFocused,function()
    sendSave:enable();
  end)
  :subscribe(hs.window.filter.windowUnfocused,function()
    sendSave:disable();
  end)

----------
-- Misc --
----------

-- Send esc using `ctrl + return`
hs.hotkey.bind({"control"}, "return", function()
  hs.eventtap.keyStroke(nil, "escape")
end)

-- Send ` using `option + '`
hs.hotkey.bind({"option"}, "'", function()
  hs.eventtap.keyStroke(nil, "`")
end)

-- Send ~ using `shift + option + '`
hs.hotkey.bind({"shift", "option"}, "'", function()
  hs.eventtap.keyStroke({"shift"}, "`")
end)
