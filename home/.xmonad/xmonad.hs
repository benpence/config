import System.IO

import XMonad
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Util.EZConfig (removeKeys)
import XMonad.StackSet (sink)

main = do
    -- Run WM-independent startup commands
    spawn "~/.xinitrc"

    xmonad $ properties
        `removeKeys`     removedKeys
        `additionalKeys` addedKeys

properties = defaultConfig
  -- Terminal to launch on Mod-Shift-Enter
  { terminal           = "urxvt"
  , workspaces         = ["1", "2", "3"]
  , modMask            = modifier

  -- Change
  , manageHook         = composeAll
    [ className =? "MPlayer" --> (ask >>= doF . sink)
    ]

  -- Window borders
  , borderWidth        = 1
  , normalBorderColor  = "#000000"
  , focusedBorderColor = "#333333"

  -- Remove specific default keys
  }
{- HOTKEYS -}

modifier = mod4Mask


addedKeys =
  -- Lock screensaver button
  [ ((modifier .|. shiftMask, xK_l),  spawn "$HOME/bin/lock")

  -- Dmenu app launcher with added font
  , ((modifier .|. shiftMask, xK_p),  spawn "dmenu_run")

  -- New combination for 'unfloating' (sink) a floating window back into the layout manager
  , ((modifier .|. shiftMask, xK_t),  withFocused $ windows . sink)

  -- Music playback
  , ((controlMask, xK_F1),            spawn "mpc prev")
  , ((controlMask, xK_F2),            spawn "mpc next")
  , ((controlMask, xK_F3),            spawn "mpc stop && mpc play")
  , ((controlMask, xK_F4),            spawn "mpc toggle && $HOME/bin/musicPlayback")

  -- Adjust backlight
  , ((0, xK_F5),                      spawn "xbacklight -3 -time 20")
  , ((0, xK_F6),                      spawn "xbacklight +3 -time 20")

  -- Volume mute, down, up for F8 F9 F10
  , ((0, xK_F8),                      spawn "$HOME/bin/volume toggle")
  , ((0, xK_F9),                      spawn "$HOME/bin/volume down")
  , ((0, xK_F10),                     spawn "$HOME/bin/volume up")
  ]

removedKeys =
  -- This has been changed to mod-shift-p
  [ (modifier, xK_p)

  -- Removed to ease emacs compatibility
  , (modifier, xK_j)
  , (modifier, xK_k)

  , (modifier, xK_Return)

  , (modifier, xK_w)
  , (modifier, xK_e)
  , (modifier, xK_r)
  , (modifier .|. shiftMask, xK_w)
  , (modifier .|. shiftMask, xK_e)
  , (modifier .|. shiftMask, xK_r)

  , (modifier, xK_t)
  ]
