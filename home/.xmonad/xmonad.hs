import XMonad
import XMonad.Util.EZConfig
import XMonad.Util.CustomKeys
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.IndependentScreens
import XMonad.Layout.LayoutModifier (ModifiedLayout)
import XMonad.Hooks.UrgencyHook
import qualified Data.Map as M
import XMonad.Hooks.ManageDocks (AvoidStruts)
import System.Environment (getEnv)
import qualified XMonad.StackSet as W
import Data.Monoid (Endo)

titleColor :: String
titleColor     = "#7488a4"

currentWSColor :: String
currentWSColor = "#e0b167"

getCurrentEnv :: IO String
getCurrentEnv = getEnv "CURRENT_ENV"

getScreenOrder :: IO [ScreenId]
getScreenOrder = do
  currentEnv <- getCurrentEnv
  return $ case currentEnv of
    "lab" -> [1, 0, 2]
    _     -> [2, 0, 1]

getKeyboardLanguage :: IO String
getKeyboardLanguage = do
  currentEnv <- getCurrentEnv
  return $ case currentEnv of
    "lab" -> "us"
    _     -> "jp"

makeKeyBindings :: IO [(String, X())]
makeKeyBindings = do
  screenOrder <- getScreenOrder
  keyboardLanguage <- getKeyboardLanguage
  return ([
      ("C-M1-f"   , spawn "google-chrome-stable")
    , ("C-M1-t"   , spawn "urxvt")
    , ("C-M1-9"   , spawn $ "xkb-switch -s " ++ keyboardLanguage)
    , ("C-M1-0"   , spawn $ "xkb-switch -s " ++ keyboardLanguage)
    , ("M1-<F4>"  , kill)
    , ("M4-h"     , sendMessage Shrink)
    , ("M4-l"     , sendMessage Expand)
    , ("<Print>"  , spawn "xwd | convert - /tmp/screenshot-$(date +%s).png")
    , ("C-<Print>", spawn "xwd -root | convert - /tmp/screenshot-$(date +%s).png")
    , ("<XF86MonBrightnessDown>", spawn "xbacklight -20")
    , ("<XF86MonBrightnessUp>",   spawn "xbacklight +20")
    ]
    ++
    [
      (mask ++ "M4-" ++ [key], screenWorkspace scr >>= flip whenJust (windows . action))
           | (key, scr)  <- zip "asd" screenOrder
           , (action, mask) <- [ (W.view, "") , (W.shift, "S-")]
    ])

keyUnbindings :: [String]
keyUnbindings =
  [
    "M-h"
  , "M-l"
  ] ++ concat [("M-" ++ [n]):["M-S-" ++ [n]] | n <- ['1'..'9']]
    ++ concat [("M-" ++ [c]):["M-S-" ++ [c]] | c <- "wer"]

mCustomKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
mCustomKeys = customKeys delkeys inskeys where
  delkeys :: XConfig l -> [(KeyMask, KeySym)]
  delkeys XConfig {} = []
  inskeys :: XConfig Layout -> [((KeyMask, KeySym), X ())]
  inskeys conf =
    [((m .|. mod4Mask, k), windows $ onCurrentScreen f i)
          | (i, k) <- zip (workspaces' conf) [xK_1 .. xK_9]
          , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

manageHooks :: Query (Data.Monoid.Endo WindowSet)
manageHooks = composeAll
  [
    isFullscreen --> doFullFloat
  , title =? "Eclipse" --> doFloat ]


workspaceNames :: [String]
workspaceNames = [show n | n <- ([1..9] :: [Integer])]

configWithDzen :: XConfig (Choose Tall (Choose (Mirror Tall) Full))
configWithDzen = withUrgencyHook dzenUrgencyHook
  {
    args = ["-bg", "darkgreen", "-xs", "2"]
  , duration = 100
  } $ defaultConfig

mainConfig :: ScreenId -> XConfig (Choose Tall (Choose (Mirror Tall) Full))
mainConfig n = configWithDzen
  { terminal           = "urxvt"
  , normalBorderColor  = "#cccccc"
  , focusedBorderColor = "#7ec7ea"
  , borderWidth        = 1
  , focusFollowsMouse  = False
  , keys               = mCustomKeys
  , startupHook        = setWMName "LG3D"
  , manageHook         = manageHooks
  , workspaces         = withScreens n workspaceNames
}

makeConfigWithKeys :: ScreenId -> IO (XConfig (Choose Tall (Choose (Mirror Tall) Full)))
makeConfigWithKeys n = do
  keyBindings <- makeKeyBindings
  return $ mainConfig n `removeKeysP` keyUnbindings `additionalKeysP` keyBindings

getBarCommand :: IO String
getBarCommand = do
  home <- getEnv "HOME"
  return $ "xmobar -x1 " ++ home ++ "/.xmobar/xmobarrc"

myPP :: PP
myPP = xmobarPP {
  ppCurrent = xmobarColor currentWSColor "" . wrap "[" "]"
, ppTitle = xmobarColor titleColor ""
}

toggleStrutsKey :: XConfig t -> (KeyMask, KeySym)
toggleStrutsKey XConfig {XMonad.modMask = mask} = (mask, xK_z)

configWithBar :: ScreenId -> IO (XConfig (ModifiedLayout AvoidStruts (Choose Tall (Choose (Mirror Tall) Full))))
configWithBar n = do
  barCommand <- getBarCommand
  configWithKeys <- makeConfigWithKeys n
  statusBar barCommand myPP toggleStrutsKey configWithKeys


main :: IO ()
main = do
  screensNumber <- countScreens
  xmonad =<< configWithBar screensNumber
