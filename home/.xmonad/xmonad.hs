import XMonad
import XMonad.Util.EZConfig
import XMonad.Util.CustomKeys
import XMonad.Layout.ResizableTile
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.IndependentScreens
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.EwmhDesktops

import XMonad.Hooks.ManageDocks (avoidStruts, docks, manageDocks)
import XMonad.Layout.Reflect (reflectVert)
import XMonad.Layout.NoBorders
import qualified XMonad.StackSet as W
import XMonad.Prompt.Pass (passPrompt)
import XMonad.Prompt (XPConfig(..), XPPosition(..), emacsLikeXPKeymap)

import qualified Data.Char as C
import qualified Data.Map as M
import qualified Data.Text as T
import Data.Monoid (Endo, All(..))
import Data.List (isInfixOf)
import System.FilePath (joinPath)
import System.Directory (doesFileExist)
import System.Environment (getEnv, lookupEnv, setEnv)

strip :: String -> String
strip  = T.unpack . T.strip . T.pack

titleColor :: String
titleColor = "#7488a4"

currentWSColor :: String
currentWSColor = "#e0b167"

defaultEnv :: String
defaultEnv = "laptop"

fuzzySearch :: String -> String -> Bool
fuzzySearch a b = isInfixOf (lower a) (lower b) where
  lower = map C.toLower

xpConfig :: XPConfig
xpConfig = def { borderColor = "#cccccc"
               , font = "xft:Ricty-Regular:pixelsize=18:antialias=true"
               , height = 30
               , position = CenteredAt 0.2 0.7
               , searchPredicate = fuzzySearch
               , promptKeymap = emacsLikeXPKeymap
               }

envFilePath :: IO FilePath
envFilePath = do
  home <- getEnv "HOME"
  return $ joinPath [home, "current_env"]

getCurrentEnvFromFile :: IO String
getCurrentEnvFromFile = do
  envFile <- envFilePath
  fileExists <- doesFileExist envFile
  if fileExists
    then readFile envFile
    else return defaultEnv

getCurrentEnv :: IO String
getCurrentEnv = do
  maybeEnv <- lookupEnv "CURRENT_ENV"
  fallbackEnv <- getCurrentEnvFromFile
  return $ maybe fallbackEnv id maybeEnv

getScreenOrder :: IO [ScreenId]
getScreenOrder = do
  maybeScreenOrder <- lookupEnv "CURRENT_ENV_SCREEN_ORDER"
  let screenOrder = maybe "201" id maybeScreenOrder
  return $ map (S . read . return) screenOrder

getKeyboardLanguage :: String -> String
getKeyboardLanguage _env = "us"

extendEnv :: IO ()
extendEnv = do
  home <- getEnv "HOME"
  currentPath <- getEnv "PATH"
  setEnv "PATH" (currentPath ++ ":" ++ joinPath [home, ".local", "bin"])

makeKeyBindings :: IO [(String, X())]
makeKeyBindings = do
  currentEnv <- getCurrentEnv
  screenOrder <- getScreenOrder
  extendEnv
  return ([
      ("C-M1-f"   , spawn "google-chrome-stable")
    , ("C-M1-t"   , spawn "kitty")
    , ("C-M1-c"   , spawn "morgen")
    , ("C-M1-s"   , spawn "flameshot gui")
    , ("C-M1-y"   , spawn "rofi -modi \"clipboard:$HOME/.local/bin/greenclip print\" -show clipboard -run-command '{cmd}'")
    , ("C-M1-m"   , spawn "mailspring --password-store=\"gnome-libsecret\"")
    , ("C-M1-9"   , spawn "sh ~/.xprofile setup_keyboard")
    , ("M1-o"     , spawn "rofi -show run")
    , ("S-M1-o"   , spawn "rofi -show window")
    , ("M1-<F4>"  , kill)
    , ("M4-h"     , sendMessage Shrink)
    , ("M4-l"     , sendMessage Expand)
    , ("M4-j"     , sendMessage MirrorShrink)
    , ("M4-k"     , sendMessage MirrorExpand)
    , ("C-M4-l"   , spawn "dm-tool lock")
    , ("<Print>"  , spawn "xwd | convert xwd:- /tmp/screenshot-$(date +%s).png")
    , ("C-<Print>", spawn "xwd -root | convert xwd:- /tmp/screenshot-$(date +%s).png")
    , ("<XF86MonBrightnessDown>", spawn "xbacklight -5")
    , ("<XF86MonBrightnessUp>",   spawn "xbacklight +5")
    , ("S-M4-p"   , passPrompt xpConfig)
    ]
    ++
    [
      (mask ++ "M4-" ++ [key], screenWorkspace scr >>= flip whenJust (windows . action))
           | (key, scr)  <- zip "asd" $ screenOrder
           , (action, mask) <- [ (W.view, "") , (W.shift, "S-")]
    ])

keyUnbindings :: [String]
keyUnbindings =
  [
    "M-h"
  , "M-l"
  , "M-p"
  , "M-n"
  , "M-<Tab>"
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
workspaceNames = map show [1..9]

myLayoutHook = avoidStruts myDefaultLayout
  where
    myDefaultLayout = resizableHalfSplitLayout ||| reflectVert resizableQuarterSplitLayout ||| Full
    resizableHalfSplitLayout = ResizableTall 1 (3/100) (1/2) []
    resizableQuarterSplitLayout = Mirror $ ResizableTall 1 (3/100) (4/5) []

mainConfig n = ewmhFullscreen . docks . ewmh $ def
  { terminal           = "urxvt"
  , normalBorderColor  = "#cccccc"
  , focusedBorderColor = "#7ec7ea"
  , borderWidth        = 1
  , focusFollowsMouse  = False
  , keys               = mCustomKeys
  , startupHook        = setWMName "LG3D"
  , manageHook         = manageHooks <+> manageDocks
  , layoutHook         = lessBorders (Combine Difference Screen OnlyScreenFloat) $ myLayoutHook
  , workspaces         = withScreens n workspaceNames
}


makeConfigWithKeys = do
  keyBindings <- makeKeyBindings
  screensNumber <- countScreens
  return $ mainConfig screensNumber `removeKeysP` keyUnbindings `additionalKeysP` keyBindings

getBarCommand :: IO String
getBarCommand = do
  home <- getEnv "HOME"
  return $ home ++ "/.local/bin/start-xmobar"

myPP :: PP
myPP = xmobarPP {
  ppCurrent = xmobarColor currentWSColor "" . wrap "[" "]"
, ppTitle = xmobarColor titleColor ""
}

toggleStrutsKey :: XConfig t -> (KeyMask, KeySym)
toggleStrutsKey XConfig {XMonad.modMask = mask} = (mask, xK_z)

configWithBar = do
  barCommand <- getBarCommand
  statusBar barCommand myPP toggleStrutsKey =<< makeConfigWithKeys


main :: IO ()
main = xmonad =<< makeConfigWithKeys
