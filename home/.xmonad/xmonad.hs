import System.IO

import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.EZConfig(removeKeys)
import XMonad.StackSet(sink)

myManageHook = composeAll
    [ className =? "Gimp"     --> doShift "3"
    , className =? "Inkscape" --> doShift "3"
    , manageDocks ]

-- Modifier is Alt
modifier = mod1Mask

main = do
    -- Run WM-independent startup commands
    spawn "~/.xinitrc"

    xmonad $ defaultConfig
        -- Terminal to launch on Mod-Shift-Enter
        { terminal           = "urxvt"

        , workspaces         = ["1", "2", "3"]
        , modMask            = modifier

        , layoutHook         = avoidStruts   $  layoutHook defaultConfig
        , manageHook         = myManageHook <+> manageHook defaultConfig
        
        -- Window borders
        , borderWidth        = 1
        , normalBorderColor  = "#000000"
        , focusedBorderColor = "#333333"

        -- Remove specific default keys
        } `removeKeys`
            -- This has been changed to mod-shift-p
            [ (modifier, xK_p)

            -- Removed to ease emacs compatibility
            , (modifier, xK_j)
            , (modifier, xK_k)

            , (modifier, xK_w)
            , (modifier, xK_e)
            , (modifier, xK_r)
            , (modifier .|. shiftMask, xK_w)
            , (modifier .|. shiftMask, xK_e)
            , (modifier .|. shiftMask, xK_r)

            , (modifier, xK_t)

        -- Hotkeys
        ] `additionalKeys`
              -- Lock screensaver button
            [ ((modifier .|. shiftMask, xK_l),  spawn "xscreensaver-command -lock")

              -- Dmenu app launcher with added font
            , ((modifier .|. shiftMask, xK_p),  spawn "dmenu_run -fn xft:Inconsolata:style=Medium:pixelsize=14")

              -- New combination for 'unfloating' (sink) a floating window back into the layout manager
            , ((modifier .|. shiftMask, xK_t),  withFocused $ windows . sink)


              -- Music playback
            , ((0, xK_F1),                      spawn "mpc prev")
            , ((0, xK_F2),                      spawn "mpc next")
            , ((0, xK_F3),                      spawn "mpc stop && mpc play")
            , ((0, xK_F4),                      spawn "mpc toggle && $HOME/bin/musicPlayback")

              -- Adjust backlight
            , ((0, xK_F6),                      spawn "xbacklight -10")
            , ((0, xK_F7),                      spawn "xbacklight +10")

              -- Volume mute, down, up for F8 F9 F10
            , ((0, xK_F8),                      spawn "$HOME/bin/volume toggle")
            , ((0, xK_F9),                      spawn "$HOME/bin/volume down")
            , ((0, xK_F10),                     spawn "$HOME/bin/volume up")
            ]
