import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main = do
  xmproc <- spawnPipe "/usr/bin/xmobar /home/hebi/.hebi/xmonad/xmobar.hs"
  xmonad =<< xmobar defaultConfig {
    manageHook = manageDocks <+> manageHook defaultConfig,
    layoutHook = avoidStruts $ layoutHook defaultConfig,
    logHook = dynamicLogWithPP xmobarPP
      { ppOutput = hPutStrLn xmproc,
        ppTitle = xmobarColor "green" "" . shorten 50
      },
    modMask = mod4Mask          -- use windows key as Mod, instead of Alt
                         }
