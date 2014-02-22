import System.IO

import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)

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

        -- Hotkeys
        } `additionalKeys`
              -- Lock screensaver button
            [ ((modifier .|. shiftMask, xK_l),  spawn "xscreensaver-command -lock")

              -- Dmenu app launcher with added font
            , ((modifier, xK_p),                spawn "dmenu_run -fn xft:Inconsolata:style=Medium:pixelsize=14")

              -- Volume mute, down, up for F8 F9 F10
            , ((0, xK_F8),                      spawn "amixer sset Master,0 toggle")
            , ((0, xK_F9),                      spawn "amixer sset Master,0 3-")
            , ((0, xK_F10),                     spawn "amixer sset Master,0 3+")
            ]
