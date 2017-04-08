--
-- "$HOME"/.xmonad/xmonad.hs by milsen
--

import Graphics.X11.ExtraTypes.XF86
import System.Exit
import System.IO
import XMonad
import XMonad.Actions.CycleWS
import XMonad.Actions.WindowGo
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Layout.NoBorders
import Data.Monoid
import qualified XMonad.StackSet as W
import qualified Data.Map        as M


-- get terminal colors
foreground       = "#c9ccca"
color0           = "#282a2e"
color1           = "#b84747"
color2           = "#518234"
color3           = "#e0925c"
color4           = "#4f7798"
color5           = "#a582b0"
color6           = "#52b6a9"
color7           = "#686f77"
color8           = "#50565e"
color9           = "#d25d5d"
color10          = "#bdc75e"
color11          = "#ebc273"
color12          = "#83a7c5"
color13          = "#c8afce"
color14          = "#82b8b1"
color15          = "#adb0ae"

-- Key bindings
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal/fzf-launcher
    [ ((modm,              xK_Return), spawn $ XMonad.terminal conf)
    , ((modm .|. mod1Mask, xK_Return), spawn "termite -r fzf-launcher --geometry 950x510+480+330 -e \"bash --rcfile ~/src/fzf-launcher/fzf-launcher\"")

    -- close focused window
    , ((modm,              xK_d     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,              xK_space ), sendMessage NextLayout)
    --  Reset the layouts on the current workspace to default
    , ((modm .|. mod1Mask, xK_space ), setLayout $ XMonad.layoutHook conf)
    -- , ((modm .|. mod1Mask, xK_space ), sendMessage PreviousLayout)

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    , ((modm,              xK_b     ), sendMessage ToggleStruts)

    -- Resize viewed windows to the correct size
    , ((modm,              xK_n     ), refresh)

    -- Cycle through workspaces
    , ((modm,              xK_Tab   ), moveTo Next NonEmptyWS)
    , ((modm .|. mod1Mask, xK_Tab   ), moveTo Prev NonEmptyWS)

    -- Move focus to the next/previous/master window
    , ((modm,              xK_l     ), windows W.focusDown)
    , ((modm,              xK_h     ), windows W.focusUp)
    , ((modm,              xK_m     ), windows W.focusMaster)

    -- Swap the focused window with the next/previous/master window
    , ((modm .|. mod1Mask, xK_l     ), windows W.swapDown)
    , ((modm .|. mod1Mask, xK_h     ), windows W.swapUp)
    , ((modm .|. mod1Mask, xK_m     ), windows W.swapMaster)

    -- Expand/shrink the master area
    , ((modm,              xK_k     ), sendMessage Expand)
    , ((modm,              xK_j     ), sendMessage Shrink)

    -- Increment/deincrement the number of windows in the master area
    , ((modm .|. mod1Mask, xK_k     ), sendMessage (IncMasterN 1))
    , ((modm .|. mod1Mask, xK_j     ), sendMessage (IncMasterN (-1)))

    -- Push window back into tiling
    , ((modm,              xK_t     ), withFocused $ windows . W.sink)

    -- Reset/quit xmonad
    , ((modm,              xK_q     ), spawn "xmonad --recompile; xmonad --restart")
    , ((modm .|. mod1Mask, xK_q     ), io (exitWith ExitSuccess))

    -- Applications
    , ((modm,              xK_o     ), spawn "termite -t music-player --geometry 800x300+780+50 -e \"music-player 300x300+1600+50\"")
    , ((modm,              xK_p     ), spawn "mpc toggle")
    , ((modm,              xK_g     ), spawn "termite -e ranger")
    , ((modm,              xK_f     ), spawn "firefox")
    , ((modm,              xK_Print ), spawn "scrot '%Y-%m-%d_%H-%M-%S.png' -e 'mv $f ~/media/images/shots' && notify-send 'Screenshot taken'")

    -- xF86 keys
    , ((0, xF86XK_AudioMute        ), spawn "amixer set Master toggle")
    , ((0, xF86XK_AudioRaiseVolume ), spawn "amixer set Master 5%+")
    , ((0, xF86XK_AudioLowerVolume ), spawn "amixer set Master 5%-")
    -- , ((0, xF86XK_AudioMicMute     ), spawn "amixer set \"Mic Boost\" toggle")
    , ((0, xF86XK_MonBrightnessDown), spawn "xbacklight -dec 10")
    , ((0, xF86XK_MonBrightnessUp  ), spawn "xbacklight -inc 10")

    ]
    ++

    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, mod1Mask)]]
    ++

    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, mod1Mask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

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

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- * NOTE: XMonad.Hooks.EwmhDesktops users must remove the obsolete
-- ewmhDesktopsLayout modifier from layoutHook. It no longer exists.
-- Instead use the 'ewmh' function from that module to modify your
-- defaultConfig as a whole. (See also logHook, handleEventHook, and
-- startupHook ewmh notes.)
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.

myLayoutHook = tiled ||| Full -- ||| Mirror tiled ||| Grid
   where
    -- default tiling algorithm partitions the screen into two panes
    tiled   = Tall nmaster delta ratio
    -- The default number of windows in the master pane
    nmaster = 1
    -- Default proportion of screen occupied by master pane
    ratio   = 1/2
    -- Percent of screen to increment by when resizing panes
    delta   = 3/100

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--

myManageHook = composeAll
    [ className =? "dunst-notification" --> doIgnore
    , className =? "MPlayer"            --> doFloat
    , title     =? "abcde_album_art"    --> doFloat
    , title     =? "cover art"          --> doF (W.focusDown)
    , title     =? "cover art"          --> doFloat
    , title     =? "music-player"       --> doFloat
    , resource  =? "desktop_window"     --> doIgnore
    , resource  =? "kdesktop"           --> doIgnore
    , role      =? "fzf-launcher"       --> doFloat
    , role      =? "gimp-toolbox"       --> doFloat ]
    where role = stringProperty "WM_WINDOW_ROLE"

------------------------------------------------------------------------
-- Event handling

-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add EWMH event handling to your custom event hooks by
-- combining them with ewmhDesktopsEventHook.
--
-- myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add EWMH logHook actions to your custom log hook by
-- combining it with ewmhDesktopsLogHook.
--
-- myLogHook = return ()

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted with
-- mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize per-workspace
-- layout choices.
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole. It will
-- add initialization of EWMH support to your custom startup hook by combining
-- it with ewmhDesktopsStartup.
--
-- myStartupHook = return ()

-- show Layout as just one character
layoutTransform :: String -> String
layoutTransform l
  | l == "Tall"        = xmobarColor color12 "" ">"
  | l == "Mirror Tall" = xmobarColor color12 "" "<"
  | l == "Full"        = xmobarColor color12 "" "*"
  | l == "Grid"        = xmobarColor color12 "" "+"
  | l == "Circle"      = xmobarColor color12 "" "O"

-- fields not overridden, will use the defaults in xmonad/XMonad/Config.hs
main = do
    xmproc <- spawnPipe "xmobar /home/m/.xmonad/.xmobarrc" -- spawn xmobar

    xmonad $ def                          -- use default config, override:
        { terminal           = "termite"  -- preferred terminal emulator
        , focusFollowsMouse  = True       -- window focus should follow mouse
        , borderWidth        = 2          -- border width in pixels
        , modMask            = mod4Mask   -- modkey is the Super key

        -- names of workspaces, their number is determined by the length of the list
        , workspaces         = ["1","2","3","4","5","6","7","8","9"]
        , normalBorderColor  = color7     -- border color for unfocused windows
        , focusedBorderColor = color11    -- border color for focused windows

        -- key bindings
        , keys               = myKeys
        , mouseBindings      = myMouseBindings

        -- hooks, layouts
        , layoutHook         = avoidStruts $ smartBorders $ myLayoutHook
        , manageHook         = manageDocks <+> myManageHook <+> manageHook def

        -- , handleEventHook    = myEventHook
        , logHook            = dynamicLogWithPP $ def
                                    { ppCurrent         = xmobarColor color11 ""
                                    , ppVisible         = wrap "<" ">"
                                    , ppHidden          = id
                                    , ppHiddenNoWindows = const ""
                                    , ppUrgent          = id
                                    , ppSep             = xmobarColor color7 "" " | "
                                    , ppWsSep           = " "
                                    , ppTitle           = shorten 110
                                    , ppLayout          = layoutTransform
                                    , ppOrder           = \(ws:layout:title:_) -> [layout++" "++ws,title]
                                    , ppOutput          = hPutStrLn xmproc
                                    , ppExtras          = []
                                    }
        -- , startupHook        = myStartupHook
        }
