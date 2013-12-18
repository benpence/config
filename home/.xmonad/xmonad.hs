import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main = do
    -- Run xmobar
--  xmproc <- spawnPipe "xmobar"

    -- Run WM-independent startup commands
    spawn "~/.xinitrc"

    xmonad $ defaultConfig
        -- Terminal to launch on Mod-Shift-Enter
        { terminal           = "urxvt"

        , layoutHook        = avoidStruts  $  layoutHook defaultConfig
        , manageHook        = manageDocks <+> manageHook defaultConfig

        -- Insert xmobar
--      , logHook           = dynamicLogWithPP xmobarPP
--          { ppOutput      = hPutStrLn xmproc
--          , ppTitle       = xmobarColor "green" "" . shorten 50
--          }
        
        -- Window borders
        , borderWidth        = 1
        , normalBorderColor  = "#000000"
        , focusedBorderColor = "#333333"

        -- Hotkeys
        } `additionalKeys`
            -- 
            [ ((mod1Mask .|. shiftMask, xK_l),  spawn "xscreensaver-command -lock")

              -- Add font to dmenu invocation
            , ((mod1Mask, xK_p),                spawn "dmenu_run -fn xft:Inconsolata:style=Medium:pixelsize=14")

              -- Volume mute, down, up for F8 F9 F10
            , ((0, xK_F8),                      spawn "amixer sset Master,0 toggle")
            , ((0, xK_F9),                      spawn "amixer sset Master,0 3-")
            , ((0, xK_F10),                     spawn "amixer sset Master,0 3+")
            ]
