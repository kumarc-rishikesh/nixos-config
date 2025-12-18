{
  settings = {
    "$mod" = "SUPER";
    "$terminal" = "kitty";
    exec-once = [ "waybar & hyprpaper & clipse -listen &" ];
    windowrulev2 = [
      "float, class:(clipse)"
      "size 622 652, class:(clipse)"
      "float, class:(nmtui)"
      "size 400 400, class:(nmtui)"
      "move 100%-400, class:(nmtui)"
      "float, class:(bluetuith)"
      "size 400 400, class:(bluetuith)"
      "move 100%-400, class:(bluetuith)"
    ];
    bind = [
      "$mod SHIFT, C, killactive,"
      "$mod SHIFT, return, exec, kitty"
      "$mod, C, exec, rofi -show calc"
      "$mod SHIFT, P, exec, rofi -show drun"
      "$mod , ESCAPE, exec, rofi -show power-menu"
      "$mod SHIFT, L, exec, hyprlock"
      "$mod, F, exec, rofi -show filebrowser"
      "$mod, C, exec, rofi -show calc"
      "$mod, B, exec, zen"
      "$mod SHIFT, B, exec, brave"
      ", Print, exec, hyprshot -m region --clipboard-only"
      "$mod, Print, exec, hyprshot -m region"
      "$mod SHIFT, Q, exec, hyprctl dispatch exit"
      #window nav
      "$mod, left, movefocus, l"
      "$mod, right, movefocus, r"
      "$mod, up, movefocus, u"
      "$mod, down, movefocus, d"
      "$mod, TAB, cyclenext,"
      #window
      "$mod, 1, workspace, 1"
      "$mod, 2, workspace, 2"
      "$mod, 3, workspace, 3"
      "$mod, 4, workspace, 4"
      "$mod, 5, workspace, 5"
      "$mod, 6, workspace, 6"
      "$mod, 7, workspace, 7"
      "$mod, 8, workspace, 8"
      "$mod, 9, workspace, 9"
      "$mod, 0, workspace, 10"
      "$mod SHIFT, 1, movetoworkspace, 1"
      "$mod SHIFT, 2, movetoworkspace, 2"
      "$mod SHIFT, 3, movetoworkspace, 3"
      "$mod SHIFT, 4, movetoworkspace, 4"
      "$mod SHIFT, 5, movetoworkspace, 5"
      "$mod SHIFT, 6, movetoworkspace, 6"
      "$mod SHIFT, 7, movetoworkspace, 7"
      "$mod SHIFT, 8, movetoworkspace, 8"
      "$mod SHIFT, 9, movetoworkspace, 9"
      "$mod SHIFT, 0, movetoworkspace, 10"
      #special
      "$mod, S, togglespecialworkspace, magic"
      "$mod SHIFT, S, movetoworkspace, special:magic"
      "$mod, V, exec, kitty --class clipse -e clipse"
    ];
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
    binde = [
      ", XF86AudioRaiseVolume , exec, amixer set Master 5%+"
      ", XF86AudioLowerVolume , exec, amixer set Master 5%-"
      ", XF86AudioMute , exec, amixer set Master toggle"
      ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
      ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      ", XF86AudioMicMute, exec, amixer set Capture toggle"
      ", F3 , exec, amixer set Master 5%+"
      ", F2 , exec, amixer set Master 5%-"
      ", F5, exec, brightnessctl set 5%+"
      ", F4, exec, brightnessctl set 5%-"
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPrev, exec, playerctl previous"
      ", XF86AudioPlay, exec, playerctl play-pause"
    ];

  };
  extraConfig = ''
    monitor = , preferred, auto, 1
    general {
        gaps_in = 2
        gaps_out = 1
        layout = dwindle
        col.active_border = rgb(44475a) # or rgb(6272a4)
        col.inactive_border = rgb(282a36)
        }
    decoration {
        rounding = 2
        active_opacity = 1
        inactive_opacity = 0.6
               
        blur {
          enabled = true
          size = 5
          passes = 5
          vibrancy = 0.1696
    }

    }     
    dwindle {
        pseudotile = true
        preserve_split = true
    }
    input {
        touchpad {
            natural_scroll = true
        }
    }
    group {
        groupbar {
            col.active = rgb(bd93f9) rgb(44475a) 90deg
            col.inactive = rgba(282a36dd)
        }
    }
    animations {
    enabled = yes, please :)

    # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

    bezier = easeOutQuint,0.23,1,0.32,1
    bezier = easeInOutCubic,0.65,0.05,0.36,1
    bezier = linear,0,0,1,1
    bezier = almostLinear,0.5,0.5,0.75,1.0
    bezier = quick,0.15,0,0.1,1

    animation = global, 1, 10, default
    animation = border, 1, 5.39, easeOutQuint
    animation = windows, 1, 4.79, easeOutQuint
    animation = windowsIn, 1, 4.1, easeOutQuint, popin 87%
    animation = windowsOut, 1, 1.49, linear, popin 87%
    animation = fadeIn, 1, 1.73, almostLinear
    animation = fadeOut, 1, 1.46, almostLinear
    animation = fade, 1, 3.03, quick
    animation = layers, 1, 3.81, easeOutQuint
    animation = layersIn, 1, 4, easeOutQuint, fade
    animation = layersOut, 1, 1.5, linear, fade
    animation = fadeLayersIn, 1, 1.79, almostLinear
    animation = fadeLayersOut, 1, 1.39, almostLinear
    animation = workspaces, 1, 1.94, almostLinear, fade
    animation = workspacesIn, 1, 1.21, almostLinear, fade
    animation = workspacesOut, 1, 1.94, almostLinear, fade
    }

    misc {
        enable_swallow = true
        swallow_regex = ^(kitty)$
    }
  '';
}
