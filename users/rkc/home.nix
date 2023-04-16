
{ pkgs, ... }:
{
home.username = "rkc";
    home.homeDirectory = "/home/rkc";
    home.packages = with pkgs; [
        firefox
        brave
        bluetuith
        alacritty
	haskellPackages.haskell-language-server
	haskellPackages.hoogle
	cabal-install
	stack
	ghc
	nitrogen
	xmobar
	vuze
        spectacle
	ranger
	multilockscreen
	localstack
	neofetch
        vim
        vscode
        wget
	awscli2
	bc
	git
	yarn
	python311
	python311.pkgs.pip
	nodejs
	docker
        xclip
        esbuild
        rofi
        brightnessctl
	standardnotes
        tdesktop
        zoom-us
        qbittorrent
        vlc
        anbox
];

    programs.home-manager = {
        enable = true;
	path = "~/.config/nixpkgs.home.nix";
	};


    programs.alacritty = {
        enable = true;
	settings = {
	font.size = 7.0;	
        colors = {
          primary = { 
            background = "#282a36";
            foreground = "#f8f8f2";
            bright_foreground = "#ffffff";
          };
         search = {
            matches.foreground = "#44475a";
            matches.background = "#50fa7b";
            focused_match.foreground = "#44475a";
            focused_match.background ="#ffb86c";
	      };
          footer_bar = {
            background = "#282a36";
            foreground = "#f8f8f2";
	    };
          hints = {
            start.foreground = "#282a36";
            start.background = "#f1fa8c";
            end.foreground = "#f1fa8c";
            end.background = "#282a36";
	    };	
          selection = {
            background = "#44475a";
	    };
          normal = { 
            black = "#21222c";
            red = "#ff5555";
            green = "#50fa7b";
            yellow = "#f1fa8c";
            blue = "#bd93f9";
            magenta = "#ff79c6";
            cyan = "#8be9fd";
            white = "#f8f8f2";
	    };
          bright ={
            black = "#6272a4";
            red = "#ff6e6e";
            green = "#69ff94";
            yellow = "#ffffa5";
            blue = "#d6acff";
            magenta = "#ff92df";
            cyan = "#a4ffff";
            white = "#ffffff";
	        };
            };
        };
    };


    programs.xmobar = {
        enable = true;
        extraConfig = '' 
            Config { 
               -- appearance
                 font =         "xft:Bitstream Vera Sans Mono:size=9:bold:antialias=true"
               , bgColor =      "black"
               , fgColor =      "#646464"
               , position =     Top
               , border =       BottomB
               , borderColor =  "#646464"
            
               -- layout
               , sepChar =  "%"   -- delineator between plugin names and straight text
               , alignSep = "}{"  -- separator between left-right alignment
               , template = " %battery% | %multicpu% | %memory% | %dynnetwork% }{ %VOBL% | %date% || %kbd% "
            
               -- general behavior
               , lowerOnStart =     True    -- send to bottom of window stack on start
               , hideOnStart =      False   -- start with window unmapped (hidden)
               , allDesktops =      True    -- show on all desktops
               , overrideRedirect = True    -- set the Override Redirect flag (Xlib)
               , pickBroadest =     False   -- choose widest display (multi-monitor)
               , persistent =       True    -- enable/disable hiding (True = disabled)
            
               -- plugins
               --   Numbers can be automatically colored according to their value. xmobar
               --   decides color based on a three-tier/two-cutoff system, controlled by
               --   command options:
               --     --Low sets the low cutoff
               --     --High sets the high cutoff
               --
               --     --low sets the color below --Low cutoff
               --     --normal sets the color between --Low and --High cutoffs
               --     --High sets the color above --High cutoff
               --
               --   The --template option controls how the plugin is displayed. Text
               --   color can be set by enclosing in <fc></fc> tags. For more details
               --   see http://projects.haskell.org/xmobar/#system-monitor-plugins.
               , commands = 
            
                    -- weather monitor
                    [ Run Weather "VOBL" [ "--template", "<skyCondition> | <fc=#4682B4><tempC></fc>°C | <fc=#4682B4><rh></fc>% | <fc=#4682B4><pressure></fc>hPa"
                                         ] 36000
            
                    -- network activity monitor (dynamic interface resolution)
                    , Run DynNetwork     [ "--template" , "<dev>: <tx>kB/s|<rx>kB/s"
                                         , "--Low"      , "1000"       -- units: B/s
                                         , "--High"     , "5000"       -- units: B/s
                                         , "--low"      , "darkgreen"
                                         , "--normal"   , "darkorange"
                                         , "--high"     , "darkred"
                                         ] 10
            
                    -- cpu activity monitor
                    , Run MultiCpu       [ "--template" , "Cpu: <total0>%|<total1>%"
                                         , "--Low"      , "50"         -- units: %
                                         , "--High"     , "85"         -- units: %
                                         , "--low"      , "darkgreen"
                                         , "--normal"   , "darkorange"
                                         , "--high"     , "darkred"
                                         ] 10
            
                                     
                    -- memory usage monitor
                    , Run Memory         [ "--template" ,"Mem: <usedratio>%"
                                         , "--Low"      , "20"        -- units: %
                                         , "--High"     , "90"        -- units: %
                                         , "--low"      , "darkgreen"
                                         , "--normal"   , "darkorange"
                                         , "--high"     , "darkred"
                                         ] 10
            
                    -- battery monitor
                    , Run Battery        [ "--template" , "Batt: <acstatus>"
                                         , "--Low"      , "10"        -- units: %
                                         , "--High"     , "80"        -- units: %
                                         , "--low"      , "darkred"
                                         , "--normal"   , "darkorange"
                                         , "--high"     , "darkgreen"
            
                                         , "--" -- battery specific options
                                                   -- discharging status
                                                   , "-o"	, "<left>% (<timeleft>)"
                                                   -- AC "on" status
                                                   , "-O"	, "<fc=#dAA520>Charging</fc>"
                                                   -- charged status
                                                   , "-i"	, "<fc=#006000>Charged</fc>"
                                         ] 50
            
                    -- time and date indicator 
                    --   (%F = y-m-d date, %a = day of week, %T = h:m:s time)
                    , Run Date           "<fc=#ABABAB>%F (%a) %T</fc>" "date" 10
            
                    -- keyboard layout indicator
                    , Run Kbd            [ ("us(dvorak)" , "<fc=#00008B>DV</fc>")
                                         , ("us"         , "<fc=#8B0000>US</fc>")
                                         ]
                    ]}
                '';
	};
    

    xsession.windowManager.xmonad = {
        enable = true;
	enableContribAndExtras = true;
        config = pkgs.writeText "xmonad.hs" ''

import XMonad
import Data.Monoid
import System.Exit
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Util.SpawnOnce
import XMonad.Util.Run
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Layout.Spacing
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.ManageDocks
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "alacritty"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
--
myBorderWidth   =  2
-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#f5cece"
myFocusedBorderColor = "#f70509"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch rofi run
    , ((modm,               xK_p     ), spawn "rofi -show run")
    
    --launch rofi filebrowser
    , ((modm,               xK_f     ), spawn "rofi -show filebrowser")

    -- launch notes
    , ((modm .|. shiftMask, xK_n     ), spawn "standardnotes")

    -- launch brave
    , ((modm,               xK_b     ), spawn "brave")
   
    -- launch file manager
    , ((modm .|. shiftMask, xK_f     ), spawn "ranger") 

    -- launch file manager
    , ((modm .|. shiftMask, xK_l     ), spawn "multilockscreen -l") 

    -- launch spectacle
    , ((modm .|. shiftMask, xK_s     ), spawn "spectacle")
    
    -- mute/unmute volume
    , ((0,                0x1008ff12 ), spawn "amixer set Master toggle")
    
    -- reduce volume by 5%
    , ((0,                0x1008ff11 ), spawn "amixer set Master 5%-")

    -- increase volume by 5%
    , ((0,                0x1008ff13 ), spawn "amixer set Master 5%+")

     -- reduce brightness by 5%
    , ((0,                0x1008ff03 ), spawn "brightnessctl set 5%-")

    -- increase brightness by 5%
    , ((0,                0x1008ff02 ), spawn "brightnessctl set +5%")

   
    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

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

    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    , ((modm .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
    
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


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
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
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = avoidStruts (tiled ||| Mirror tiled ||| Full)
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
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook = return ()

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do
        spawnOnce "nitrogen --restore &"
        spawnOnce "picom &"

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = do 
--    xmonad  $ def
--      { layoutHook = spacingWithEdge 2 $ myLayout} *>
    xmproc <- spawnPipe "xmobar ~/.config/xmobar/.xmobarrc"
    xmonad $ docks defaults




-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }`additionalKeys`
    [ 
        ((0                                    ,0xE030E0B0) , spawn "amixer -q sset Master 2%+"),
        ((0                                    ,0xE030E0AE) , spawn "amixer -q sset Master 2%-"),
        ((0                                    ,0xE030E0A0) , spawn "amixer set Master toggle")
    ]


-- | Finally, a copy of the default bindings in simple textual tabular format.
help :: String
help = unlines ["The default modifier key is 'alt'. Default keybindings:",
    "",
    "-- launching and killing programs",
    "mod-Shift-Enter  Launch xterminal",
    "mod-p            Launch dmenu",
    "mod-Shift-p      Launch gmrun",
    "mod-Shift-c      Close/kill the focused window",
    "mod-Space        Rotate through the available layout algorithms",
    "mod-Shift-Space  Reset the layouts on the current workSpace to default",
    "mod-n            Resize/refresh viewed windows to the correct size",
    "",
    "-- move focus up or down the window stack",
    "mod-Tab        Move focus to the next window",
    "mod-Shift-Tab  Move focus to the previous window",
    "mod-j          Move focus to the next window",
    "mod-k          Move focus to the previous window",
    "mod-m          Move focus to the master window",
    "",
    "-- modifying the window order",
    "mod-Return   Swap the focused window and the master window",
    "mod-Shift-j  Swap the focused window with the next window",
    "mod-Shift-k  Swap the focused window with the previous window",
    "",
    "-- resizing the master/slave ratio",
    "mod-h  Shrink the master area",
    "mod-l  Expand the master area",
    "",
    "-- floating layer support",
    "mod-t  Push window back into tiling; unfloat and re-tile it",
    "",
    "-- increase or decrease number of windows in the master area",
    "mod-comma  (mod-,)   Increment the number of windows in the master area",
    "mod-period (mod-.)   Deincrement the number of windows in the master area",
    "",
    "-- quit, or restart",
    "mod-Shift-q  Quit xmonad",
    "mod-q        Restart xmonad",
    "mod-[1..9]   Switch to workSpace N",
    "",
    "-- Workspaces & screens",
    "mod-Shift-[1..9]   Move client to workspace N",
    "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
    "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
    "",
    "-- Mouse bindings: default actions bound to mouse events",
    "mod-button1  Set the window to floating mode and move by dragging",
    "mod-button2  Raise the window to the top of the stack",
    "mod-button3  Set the window to floating mode and resize by dragging"]
	'';
    };

    programs.neovim = {
        enable = true;
	coc.enable = false;
	plugins = with pkgs.vimPlugins;[
	    vim-sensible
	    {
	        plugin = nerdtree;
		config = "let g:NERDTreeMinimalUI = 1";
	    }
	    purescript-vim
	    dracula-nvim
	];
	viAlias = true;
	extraConfig = ''
	    set clipboard+=unnamedplus
	    syntax enable
	'';
    };

    home.stateVersion = "22.11";


    
    nixpkgs.config.allowUnfree = true;
}
