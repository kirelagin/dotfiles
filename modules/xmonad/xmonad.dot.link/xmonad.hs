{-# LANGUAGE UnicodeSyntax #-}

import Prelude.Unicode
import Data.Monoid
import Data.Monoid.Unicode
import Control.Monad
import Control.Monad.Unicode
import System.Exit

import XMonad
import qualified XMonad.StackSet as W

import XMonad.Core (withDisplay, runQuery)
import XMonad.Operations (withFocused)
import XMonad.ManageHook (title)

import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat)

import XMonad.Actions.PhysicalScreens
import XMonad.Actions.SpawnOn

import XMonad.Hooks.SetWMName

import XMonad.Layout.Gaps
import XMonad.Layout.Magnifier
import XMonad.Layout.MouseResizableTile
import XMonad.Layout.NoBorders
import XMonad.Layout.WindowNavigation

import XMonad.Config.Desktop
import XMonad.Config.Kde

import XMonad.Util.EZConfig
import XMonad.Util.WindowProperties (getProp32s)


--layouts = gaps [(L, 1)] common
layouts = common
  where
    common = smartBorders $ tiled ||| Mirror tiled ||| Full
    tiled = windowNavigation $ magnifiercz 1 $ mouseResizableTile {masterFrac = 3/5, draggerType = FixedDragger 1 3}

myManageHooks = composeAll ∘ concat $
    [ [className =? c --> doFloat | c <- floats]
    , [isFullscreen --> doFullFloat]
    ]
  where
    floats = []

hereLauncher launcher = "exe=$(" ⧺ launcher ⧺ ") && exec $exe"
dmenuLauncher profile dmargs = hereLauncher $ concat ["yeganesh -p ", profile, " -- -fn 'Dejavu Sans Mono:size=8' ", dmargs]

showNotify ∷ String → String → Maybe String → X ()
showNotify summary body Nothing = spawn $ "notify-send '" ⧺ summary ⧺ "' '" ⧺ body ⧺ "'"
showNotify summary body (Just icon) = spawn $ "notify-send '" ⧺ summary ⧺ "' '" ⧺ body ⧺ "' --icon=" ⧺ icon

showWindowName ∷ Window → X ()
showWindowName w = runQuery title w ≫= flip (showNotify "Window title") Nothing


main = xmonad conf
  where
    basicConf = kde4Config
    conf = basicConf  { layoutHook              = desktopLayoutModifiers layouts
                      , modMask                 = mod4Mask
                      , manageHook              = myManageHooks
                                                    <+> manageSpawn
                                                    <+> (liftM (not) (className =? "krunner") --> manageHook kde4Config)
                                                    <+> (kdeOverride --> doFloat)
                      , logHook                 = logHook basicConf {-<+> fadeInactiveLogHook 0.9-}
                      , startupHook             = startupHook basicConf <+> setWMName "LG3D" <+> spawn "compton"
                      , handleEventHook         = handleEventHook basicConf ⊕ fullscreenEventHook
                      , borderWidth             = 1
                      , normalBorderColor       = "black"
                      , focusedBorderColor      = "blue"
                      , workspaces              = ["1", "web", "3", "4", "5", "6", "7", "8", "gimp"]
                      }
                      `additionalKeysP`
                        [ ("M-S-<Space>",   sendMessage NextLayout) -- %! Rotate through the available layout algorithms
                  --    , ("M-S-C-<Space>", setLayout $ XMonad.layoutHook conf) -- %!  Reset the layouts on the current workspace to default
                        , ("C-q",           return ())
                        , ("M-w",           kill)
                        , ("M-C-q",         io (exitWith ExitSuccess))
                        , ("M-S-q",         spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi") -- %! Restart xmonad
                        , ("M1-<Tab>",      windows W.focusDown)
                        , ("M1-S-<Tab>",    windows W.focusUp)
                        , ("M-M1-h",        sendMessage Shrink)
                        , ("M-M1-l",        sendMessage Expand)
                        , ("M-M1-j",        sendMessage ExpandSlave)
                        , ("M-M1-k",        sendMessage ShrinkSlave)
                  --    , ("M-h",           sendMessage $ Go L)
                  --    , ("M-l",           sendMessage $ Go R)
                  --    , ("M-j",           sendMessage $ Go D)
                  --    , ("M-k",           sendMessage $ Go U)
                        , ("M-=",           sendMessage MagnifyMore)
                        , ("M--",           sendMessage MagnifyLess)
                  --    , ("<F9>",          namedScratchpadAction scratchpads "konsole")
                  --    , ("<F9>",          scratchpadSpawnActionTerminal "urxvt")
                        , ("M-r",           spawnHere $ dmenuLauncher "launch"
                                                                      "-nb '#466300' -nf '#FFFFFF' -sb '#d0e798' -sf '#2b3d00'")
                        , ("M-S-r",         spawnHere $ hereLauncher "i3-dmenu-desktop")
                        , ("M1-<F2>",       spawnHere "qmenu_hud")
                        , ("M-C-u",         spawn "udiskie-umount -2 -a")

                        , ("M-w",           onPrevNeighbour W.view)
                        , ("M-e",           onNextNeighbour W.view)
                        , ("M-M1-w",        onPrevNeighbour W.shift)
                        , ("M-M1-e",        onNextNeighbour W.shift)

                        , ("M-S-t",         withFocused showWindowName)
                        ]
--                      `additionalKeys`
--                        [((modMask conf .|. mask, key), f sc)
--                            | (key, sc) ← zip [xK_w, xK_e, xK_r] [0..]
--                            , (f, mask) ← [(viewScreen, 0), (sendToScreen, shiftMask)]]
                      `removeKeysP`
                        [ "M-<Space>"
                  --    , "M-w"
                  --    , "M-e"
                        , "M-S-c"
                        ]


kdeOverride :: Query Bool
kdeOverride = ask >>= \w -> liftX $ do
    override <- getAtom "_KDE_NET_WM_WINDOW_TYPE_OVERRIDE"
    wt <- getProp32s "_NET_WM_WINDOW_TYPE" w
    return $ maybe False (fromIntegral override ∈) wt
