import XMonad
import XMonad.Util.EZConfig
import XMonad.Util.CustomKeys
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageHelpers
import qualified XMonad.StackSet as W

keysBindings :: [(String, X())]
keysBindings =
  [
    ("C-M1-f"   , spawn "firefox")
  , ("C-M1-t"   , spawn "terminator")
  , ("M1-<F4>"  , kill)
  , ("M1-<Tab>" , windows W.focusDown)
  , ("M4-h"     , sendMessage Shrink)
  , ("M4-l"     , sendMessage Expand)
  , ("<Print>"  , spawn "xwd | convert - /tmp/screenshot-$(date +%s).png")
  , ("C-<Print>", spawn "xwd -root | convert - /tmp/screenshot-$(date +%s).png")
  ]

keyUnbindings :: [String]
keyUnbindings =
  [
    "M-h"
  , "M-l"
  ] ++ ["M-" ++ [n] | n <- ['1'..'9']]

mCustomKeys = customKeys delkeys inskeys where
  delkeys :: XConfig l -> [(KeyMask, KeySym)]
  delkeys XConfig {modMask = modm} = []
  inskeys :: XConfig Layout -> [((KeyMask, KeySym), X ())]
  inskeys conf@(XConfig {XMonad.modMask = modMask}) =
    [((m .|. mod4Mask, k), windows $ f i)
          | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
          , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

manageHooks = composeOne [isFullscreen -?> doFullFloat]

mainConfig = defaultConfig
  { terminal           = "terminator"
  , normalBorderColor  = "#cccccc"
  , focusedBorderColor = "#7ec7ea"
  , borderWidth        = 1
  , focusFollowsMouse  = False
  , keys               = mCustomKeys
  , startupHook        = setWMName "LG3D"
  , manageHook         = manageHooks
}

configWithKeys = mainConfig `removeKeysP` keyUnbindings
                            `additionalKeysP` keysBindings

barCommand = "xmobar /home/daniel/.xmobar/xmobarrc"
myPP = xmobarPP
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_z)

configWithBar = statusBar barCommand myPP toggleStrutsKey configWithKeys

main = xmonad =<< configWithBar
