{ wallpaper }:
{
  settings = {
    prefer-no-csd = true;
    hotkey-overlay.skip-at-startup = true;

    spawn-at-startup = [
      {
        command = [
          "swaybg"
          "-i"
          "${wallpaper}"
          "-m"
          "fill"
        ];
      }
      {
        command = [
          "wl-paste"
          "--watch"
          "cliphist"
          "store"
          "&"
        ];
      }
      { command = [ "waybar" ]; }
    ];
    layout = {
      default-column-width.proportion = 0.45;
      gaps = 16;
      struts = {
        left = 8;
        right = 8;
        top = 8;
        bottom = 8;
      };
    };

    binds = {
      "Mod+Shift+Return".action.spawn = [ "alacritty" ];
      "Mod+Shift+C".action.close-window = { };
      "Mod+Shift+Q".action.quit = { };

      "Mod+Shift+P".action.spawn = [
        "rofi"
        "-show"
        "drun"
      ];
      "Mod+C".action.spawn = [
        "rofi"
        "-show"
        "calc"
      ];
      "Mod+F".action.spawn = [
        "rofi"
        "-show"
        "filebrowser"
      ];
      "Mod+Escape".action.spawn = [
        "rofi"
        "-show"
        "power-menu"
      ];
      "Mod+R".action.switch-preset-column-width = { };
      "Mod+B".action.spawn = [ "zen-beta" ];
      "Mod+Shift+B".action.spawn = [ "brave" ];
      "Mod+V".action.spawn = [
        "sh"
        "-c"
        "cliphist list | rofi -dmenu -p 'Clipboard' | cliphist decode | wl-copy"
      ];
      "Mod+Shift+L".action.spawn = [ "hyprlock" ];

      "Mod+S".action.spawn = [
        "sh"
        "-c"
        "grim -g \"$(slurp)\" - | wl-copy"
      ];
      "Mod+Shift+S".action.spawn = [
        "sh"
        "-c"
        "grim -g \"$(slurp)\" ~/Pictures/screenshot-$(date +%s).png"
      ];
      "Mod+Minus".action.set-column-width = "-10%";
      "Mod+Equal".action.set-column-width = "+10%";

      "Mod+Left".action.focus-column-left = { };
      "Mod+Right".action.focus-column-right = { };
      "Mod+Up".action.focus-workspace-up = { };
      "Mod+Down".action.focus-workspace-down = { };

      "Mod+Shift+Up".action.move-column-to-workspace-up = { };
      "Mod+Shift+Down".action.move-column-to-workspace-down = { };

      "XF86AudioRaiseVolume".action.spawn = [
        "amixer"
        "set"
        "Master"
        "5%+"
      ];
      "XF86AudioLowerVolume".action.spawn = [
        "amixer"
        "set"
        "Master"
        "5%-"
      ];
      "XF86AudioMute".action.spawn = [
        "amixer"
        "set"
        "Master"
        "toggle"
      ];
      "XF86AudioMicMute".action.spawn = [
        "amixer"
        "set"
        "Capture"
        "toggle"
      ];
      "XF86MonBrightnessUp".action.spawn = [
        "brightnessctl"
        "set"
        "5%+"
      ];
      "XF86MonBrightnessDown".action.spawn = [
        "brightnessctl"
        "set"
        "5%-"
      ];
      "XF86AudioNext".action.spawn = [
        "playerctl"
        "next"
      ];
      "XF86AudioPrev".action.spawn = [
        "playerctl"
        "previous"
      ];
      "XF86AudioPlay".action.spawn = [
        "playerctl"
        "play-pause"
      ];
    };
    animations = {
      enable = true;

      window-open.kind.spring = {
        damping-ratio = 0.8;
        stiffness = 1000;
        epsilon = 0.0001;
      };

      window-close.kind.spring = {
        damping-ratio = 0.8;
        stiffness = 1000;
        epsilon = 0.0001;
      };

      window-movement.kind.spring = {
        damping-ratio = 0.8;
        stiffness = 800;
        epsilon = 0.0001;
      };

      workspace-switch.kind.spring = {
        damping-ratio = 0.8;
        stiffness = 800;
        epsilon = 0.0001;
      };
    };
  };
}
