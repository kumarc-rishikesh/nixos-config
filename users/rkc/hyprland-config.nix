{
  
  settings = {
      "$mod" = "SUPER";
      exec-once = "waybar & hyprpaper &";
      monitor = ",preferred,auto,1.0";
      windowrulev2 = [
        "float,class:(Rofi),title:(rofi - Screenshot)"
        "center,class:(Rofi),title:(rofi - Screenshot)"
        ];
      bind = [
          "$mod SHIFT, C, killactive,"
          "$mod SHIFT, return, exec, kitty"
          "$mod, B, exec, brave"
          #window nav
          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"
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
          ];
      bindm =[ 
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
          ", Print, exec, rofi-screenshot"
          # ". XF86AudioNext, exec, playerctl next"
          # ". XF86AudioPrev, exec, playerctl previous"
          # ". XF86AudioPlay, exec, playerctl play-pause"
         ];

  };
extraConfig = ''
    general {
        gaps_in = 2
        gaps_out = 5
        layout = dwindle
    }
    decoration {
        rounding = 2
        active_opacity = 0.95
        inactive_opacity = 0.8
        blur {         
            enabled = true
            size = 3
            passes = 1
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
  '';
}
