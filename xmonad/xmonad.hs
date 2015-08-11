{-# LANGUAGE FlexibleContexts #-}

import qualified Data.Map        as M
import           Data.Monoid
import           Data.List              ( intercalate )
import           System.Exit
import           System.IO              ( hPutStrLn )

import           XMonad
import           XMonad.Actions.CycleWS
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.ManageDocks
import           XMonad.Layout.Spacing
import qualified XMonad.StackSet as W
import           XMonad.Util.Scratchpad ( scratchpadSpawnAction )
import           XMonad.Util.Run        ( spawnPipe )


-- default terminal
term :: String
term = "urxvtc"


-- whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True


-- whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False


-- width of the window border in pixels.
myBorderWidth :: Dimension
myBorderWidth = 5


-- 'windows' key is default modifier
myModMask :: KeyMask
myModMask = mod4Mask


-- list of workspaces
myWorkspaces :: [String]
myWorkspaces = clickable ["dev","www","code","mpd","misc","mail","im"]
 where
  action i w = "<action=`xdotool key super+" ++ show i ++ "`>" ++ w ++ "</action>"
  clickable  = zipWith action [1..]


-- border colors
myNormalBorderColor, myFocusedBorderColor :: String
myNormalBorderColor  = "#000000"
myFocusedBorderColor = "#333333"


font :: String
font = "PragmataPro:size=11"


dmenu :: String
dmenu = "dmenu_run " ++ unwords
  [ "-fn", font
  , "-nb", "'#000000'"
  , "-nf", "'#999999'"
  , "-sf", "'#ff6600'"
  , "-sb", "'#333333'"
  , "-p" , "'run: '"
  ]


-- key bindings
myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm,               xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    , ((modm,               xK_p     ), spawn dmenu)

    -- close focused window
    , ((modm,               xK_Escape), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- scratchpad
    , ((modm,               xK_s     ), scratchpadSpawnAction conf)

    -- cycle workspaces
    , ((modm,               xK_Left  ), moveTo Prev NonEmptyWS)
    , ((modm .|. mod1Mask,  xK_h     ), moveTo Prev NonEmptyWS)
    , ((modm,               xK_Right ), moveTo Next NonEmptyWS)
    , ((modm .|. mod1Mask,  xK_l     ), moveTo Next NonEmptyWS)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm .|. shiftMask, xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. controlMask, xK_j   ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. controlMask, xK_k   ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


-- mouse bindings
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]


-- workspace layouts
myLayout = (sp tiled) ||| (sp $ Mirror tiled) ||| Full
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

     -- with spacing applied
     sp = spacing 16


-- custom window rules
myManageHook :: Query (Endo WindowSet)
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , className =? "Kodi"           --> doFloat
    , className =? "Firefox"        --> doShift (myWorkspaces !! 1)
    , resource  =? "desktop_window" --> doIgnore
    ]


------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook :: Event -> X All
myEventHook = mempty


-- startup hook: do nothing for now
myStartupHook :: X ()
myStartupHook = return ()


-- spawn xmobar using a pipe
myxmobar cfg = do
  pipe <- spawnPipe xmobarPipe
  return $ cfg
    { logHook = dynamicLogWithPP $ def
      { ppOutput        = hPutStrLn pipe
      , ppHidden        = xmobarColor "#555555" ""
      , ppCurrent       = xmobarColor "#ffffff" ""
      , ppUrgent        = xmobarColor "#ff6600" ""
      , ppSep           = xmobarSep
      , ppTitle         = shorten 70
      , ppTitleSanitize = xmobarStrip
      , ppOrder         = \(ws:_lay:t:xs) -> ws : t : xs
      }
    -- place docks on top
    , manageHook = manageHook cfg <+> manageDocks
    -- make room for docks
    , layoutHook = avoidStruts $ layoutHook cfg
    }

-- xmobar configuration
xmobarPipe :: String
xmobarPipe =
  bar ++ foreground ++ template ++ barfont ++ iconPath ++ cmds
 where
  bar        = "/home/kongo/.cabal/bin/xmobar"
  iconPath   = " -i /home/kongo/.xmonad/icons/xbm "
  barfont    = " -f " ++ "xft:" ++ font
  foreground = " -F '#aaaaaa' "
  template   = " -t '%UnsafeStdinReader%}" ++ center ++ "{" ++ right ++ "'"

  center = icon "note" ++ " %mpd%"

  right      = intercalate xmobarSep
    [ icon "cpu" ++ " %cpu%"
    , icon "mem" ++ " %memory%"
    , "%disku%"
    , "%br0%"
    , icon "clock" ++ " %date%"
    ]

  cmds = " -c '[" ++ intercalate ","
    [ "Run Cpu [\"-L\",\"3\",\"-H\",\"50\",\"-n\",\"green\",\"-h\",\"red\",\"-t\",\"<total>%\"] 20"
    , "Run Memory [\"-t\",\"<usedratio>% (<used> MB / <available> MB)\"] 100"
    , "Run Network \"br0\" [\"-t\",\"" ++ icon "net_down_03" ++ " <rx> " ++ icon "net_up_03" ++ " <tx>\"] 20"
    , "Run Date \"%a %b %_d %Y %H:%M\" \"date\" 600"
    , "Run MPD [\"-b\",\" \",\"-f\",\"_\",\"-t\",\"<artist> - <title> <fc=#555555>[<bar>]</fc>\"] 50"
    , "Run DiskU [(\"/\",\"" ++ icon "diskette" ++ " <used>/<size>\"),(\"/home\",\"" ++ icon "diskette" ++ " <used>/<size>\")] [] 600"
    , "Run UnsafeStdinReader"
    ] ++ "]'"


icon :: String -> String
icon name = "<icon=" ++ name ++ ".xbm/>"


xmobarSep :: String
xmobarSep = xmobarColor "#ff6600" "" " | "


myConfig = def
  { terminal           = term
  , focusFollowsMouse  = myFocusFollowsMouse
  , clickJustFocuses   = myClickJustFocuses
  , borderWidth        = myBorderWidth
  , modMask            = myModMask
  , workspaces         = myWorkspaces
  , normalBorderColor  = myNormalBorderColor
  , focusedBorderColor = myFocusedBorderColor

  -- key bindings
  , keys               = myKeys
  , mouseBindings      = myMouseBindings

  -- hooks, layouts
  , layoutHook         = myLayout
  , manageHook         = myManageHook
  , handleEventHook    = myEventHook
  , startupHook        = myStartupHook
  }


main :: IO ()
main = xmonad =<< myxmobar myConfig
