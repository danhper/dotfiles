import XMonad
import XMonad.Util.EZConfig
import XMonad.Util.CustomKeys
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.IndependentScreens
import XMonad.Hooks.UrgencyHook
import qualified XMonad.StackSet as W

titleColor     = "#7488a4"
currentWSColor = "#e0b167"


keysBindings :: [(String, X())]
keysBindings =
  [
    ("C-M1-f"   , spawn "google-chrome-stable")
  , ("C-M1-t"   , spawn "terminator")
  , ("M1-<F4>"  , kill)
  , ("M4-h"     , sendMessage Shrink)
  , ("M4-l"     , sendMessage Expand)
  , ("<Print>"  , spawn "xwd | convert - /tmp/screenshot-$(date +%s).png")
  , ("C-<Print>", spawn "xwd -root | convert - /tmp/screenshot-$(date +%s).png")
  ]
  ++
  [
    (mask ++ "M4-" ++ [key], screenWorkspace scr >>= flip whenJust (windows . action))
         | (key, scr)  <- zip "asd" [2,0,1] -- was [0..] *** change to match your screen order ***
         , (action, mask) <- [ (W.view, "") , (W.shift, "S-")]
  ]

keyUnbindings :: [String]
keyUnbindings =
  [
    "M-h"
  , "M-l"
  ] ++ concat [("M-" ++ [n]):["M-S-" ++ [n]] | n <- ['1'..'9']]
    ++ concat [("M-" ++ [c]):["M-S-" ++ [c]] | c <- "wer"]

mCustomKeys = customKeys delkeys inskeys where
  delkeys :: XConfig l -> [(KeyMask, KeySym)]
  delkeys XConfig {modMask = modm} = []
  inskeys :: XConfig Layout -> [((KeyMask, KeySym), X ())]
  inskeys conf@(XConfig {XMonad.modMask = modMask}) =
    [((m .|. mod4Mask, k), windows $ onCurrentScreen f i)
          | (i, k) <- zip (workspaces' conf) [xK_1 .. xK_9]
          , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

manageHooks = composeAll
  [
    isFullscreen --> doFullFloat
  , title =? "Eclipse" --> doFloat ]


workspaceNames = [show n | n <- [1..9]]

configWithDzen = withUrgencyHook dzenUrgencyHook
  {
    args = ["-bg", "darkgreen", "-xs", "2"]
  , duration = 100
  } $ defaultConfig

mainConfig n = configWithDzen
  { terminal           = "terminator"
  , normalBorderColor  = "#cccccc"
  , focusedBorderColor = "#7ec7ea"
  , borderWidth        = 1
  , focusFollowsMouse  = False
  , keys               = mCustomKeys
  , startupHook        = setWMName "LG3D"
  , manageHook         = manageHooks
  , workspaces         = withScreens n workspaceNames
}

configWithKeys n = mainConfig n `removeKeysP` keyUnbindings
                                `additionalKeysP` keysBindings

barCommand = "xmobar -x1 /home/daniel/.xmobar/xmobarrc"

myPP = xmobarPP {
  ppCurrent = xmobarColor currentWSColor "" . wrap "[" "]"
, ppTitle = xmobarColor titleColor ""
}

toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_z)

configWithBar n = statusBar barCommand myPP toggleStrutsKey (configWithKeys n)


main = do
  screensNumber <- countScreens
  xmonad =<< configWithBar screensNumber
