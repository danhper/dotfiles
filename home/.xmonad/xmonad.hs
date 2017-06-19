import XMonad
import XMonad.Util.EZConfig
import XMonad.Util.CustomKeys
import XMonad.Layout.ResizableTile
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.IndependentScreens
import XMonad.Hooks.UrgencyHook
import qualified Data.Map as M
import XMonad.Layout.NoBorders (smartBorders)
import System.Environment (getEnv)
import qualified XMonad.StackSet as W
import Data.Monoid (Endo)

titleColor :: String
titleColor = "#7488a4"

currentWSColor :: String
currentWSColor = "#e0b167"

getCurrentEnv :: IO String
getCurrentEnv = getEnv "CURRENT_ENV"

getScreenOrder :: String -> [ScreenId]
getScreenOrder "lab"          = [1, 0, 2]
getScreenOrder "home-desktop" = [1, 0, 2]
getScreenOrder _env           = [2, 0, 1]

getKeyboardLanguage :: String -> String
getKeyboardLanguage _env = "us"

makeKeyBindings :: IO [(String, X())]
makeKeyBindings = do
  currentEnv <- getCurrentEnv
  return ([
      ("C-M1-f"   , spawn "google-chrome-stable")
    , ("C-M1-t"   , spawn "urxvt")
    , ("C-M1-9"   , spawn $ "xkb-switch -s " ++ getKeyboardLanguage currentEnv)
    , ("C-M1-0"   , spawn $ "xkb-switch -s fr")
    , ("M1-o"     , spawn $ "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")
    , ("M1-<F4>"  , kill)
    , ("M4-h"     , sendMessage Shrink)
    , ("M4-l"     , sendMessage Expand)
    , ("M4-j"     , sendMessage MirrorShrink)
    , ("M4-k"     , sendMessage MirrorExpand)
    , ("<Print>"  , spawn "xwd | convert xwd:- /tmp/screenshot-$(date +%s).png")
    , ("C-<Print>", spawn "xwd -root | convert xwd:- /tmp/screenshot-$(date +%s).png")
    , ("<XF86MonBrightnessDown>", spawn "xbacklight -5")
    , ("<XF86MonBrightnessUp>",   spawn "xbacklight +5")
    ]
    ++
    [
      (mask ++ "M4-" ++ [key], screenWorkspace scr >>= flip whenJust (windows . action))
           | (key, scr)  <- zip "asd" $ getScreenOrder currentEnv
           , (action, mask) <- [ (W.view, "") , (W.shift, "S-")]
    ])

keyUnbindings :: [String]
keyUnbindings =
  [
    "M-h"
  , "M-l"
  , "M-p"
  , "M-n"
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
  , title =? "Eclipse" --> doFloat
  , className =? "albert" --> doCenterFloat ]


workspaceNames :: [String]
workspaceNames = [show n | n <- ([1..9] :: [Integer])]

resizableLayout = ResizableTall 1 (3/100) (1/2) []
myLayoutHook = resizableLayout ||| Mirror resizableLayout ||| Full

-- configWithDzen :: XConfig (Choose Tall (Choose (Mirror Tall) Full))
configWithDzen = withUrgencyHook dzenUrgencyHook
  {
    args = ["-bg", "darkgreen", "-xs", "2"]
  , duration = 100
  } $ defaultConfig

-- mainConfig :: ScreenId -> XConfig (Choose Tall (Choose (Mirror Tall) Full))
mainConfig n = configWithDzen
  { terminal           = "urxvt"
  , normalBorderColor  = "#cccccc"
  , focusedBorderColor = "#7ec7ea"
  , borderWidth        = 1
  , focusFollowsMouse  = False
  , keys               = mCustomKeys
  , startupHook        = setWMName "LG3D"
  , manageHook         = manageHooks
  , layoutHook         = smartBorders $ myLayoutHook
  , workspaces         = withScreens n workspaceNames
}

-- makeConfigWithKeys :: ScreenId -> IO (XConfig (Choose Tall (Choose (Mirror Tall) Full)))
makeConfigWithKeys n = do
  keyBindings <- makeKeyBindings
  return $ mainConfig n `removeKeysP` keyUnbindings `additionalKeysP` keyBindings

xmobarConfig "laptop-vaio-2016" = "xmobarrc-laptop"
xmobarConfig _ = "xmobarrc"

getBarCommand :: IO String
getBarCommand = do
  home <- getEnv "HOME"
  currentEnv <- getCurrentEnv
  return $ "xmobar -x1 " ++ home ++ "/.xmobar/" ++ (xmobarConfig currentEnv)

myPP :: PP
myPP = xmobarPP {
  ppCurrent = xmobarColor currentWSColor "" . wrap "[" "]"
, ppTitle = xmobarColor titleColor ""
}

toggleStrutsKey :: XConfig t -> (KeyMask, KeySym)
toggleStrutsKey XConfig {XMonad.modMask = mask} = (mask, xK_z)

-- configWithBar :: ScreenId -> IO (XConfig (ModifiedLayout AvoidStruts (Choose Tall (Choose (Mirror Tall) Full))))
configWithBar n = do
  barCommand <- getBarCommand
  configWithKeys <- makeConfigWithKeys n
  statusBar barCommand myPP toggleStrutsKey configWithKeys


main :: IO ()
main = do
  screensNumber <- countScreens
  xmonad =<< configWithBar screensNumber
