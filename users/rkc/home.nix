{
  pkgs,
  pkgs-unstable,
  pkgs-old,
  inputs,
  system,
  config,
  anyrun,
  ...
}:
let
  hyprland-config = import ./de-configs/hyprland-config.nix;
  waybar-config = import ./de-configs/waybar-conf.nix;
  hyprlock-config = builtins.readFile ./de-configs/hyprlock.conf;
  helix-config = import ./editor-configs/helix-config.nix;
  nixvim-config = import ./editor-configs/nixvim-config.nix { inherit pkgs; };
  nixvim = import (
    builtins.fetchGit {
      url = "https://github.com/nix-community/nixvim";
      ref = "nixos-26.05";
    }
  );
  zen = inputs.zen-browser.packages.${system}.default;
  wallpaperPkg = inputs.thinknix-wallpaper.packages.${pkgs.stdenv.hostPlatform.system}.default;
  wallpaper = pkgs.runCommand "thinknix-d.png" { buildInputs = [ pkgs.resvg ]; } ''
    resvg ${wallpaperPkg}/share/backgrounds/gnome/thinknix-d.svg $out
  '';
  niri-config = import ./de-configs/niri-config.nix { inherit wallpaper; };
in
{
  imports = [
    nixvim.homeModules.nixvim
  ];
  home.username = "rkc";
  home.homeDirectory = "/home/rkc";
  # nixpkgs.overlays = [
  #   (final: prev: {
  # spark = prev.spark.overrideAttrs (oldAttrs: {
  #   postInstall = ''
  #     mkdir -p $out/share/doc/spark/
  #     mv $out/LICENSE $out/NOTICE $out/share/doc/spark/
  #   '';
  # });

  #   scala = prev.scala.overrideAttrs (oldAttrs: {
  #     postInstall = ''
  #       mkdir -p $out/share/doc/scala/
  #       mv $out/LICENSE $out/NOTICE $out/share/doc/scala/
  #     '';
  #   });
  # })
  # ];
  home.packages =
    with pkgs;
    [
      busybox
      bluetuith
      feh
      alsa-utils
      fastfetch
      wget
      bc
      git
      xclip
      brightnessctl
      libqalculate
      todo
      tlp
      wpa_supplicant_gui
      qemu
      gparted
      playerctl
      libnotify
      ripgrep
      clipse
      wl-clipboard
      ngrok
      awscli2
      zlib
      zlib.dev
      lldb
      # hyprshot
      grim
      slurp
      # hyprpaper
      swaybg
      distrobox
      cheese
      jq
      localstack
      pwvucontrol
    ]
    ++ [
      rustc
      rust-analyzer
      rustfmt
      cargo
      python314
      python314.pkgs.pip
      poetry
      python314Packages.python-lsp-server
      nil
      nixfmt
      cmake
      gcc
      haskellPackages.haskell-language-server
      haskellPackages.hoogle
      haskellPackages.fourmolu
      cabal-install
      ghcid
      cabal2nix
      haskellPackages.zlib
      stack
      ghc
      miller
      scala
      jdk11
      # spark
      sbt
      mill
      metals
      scala-cli
      scalafmt
      ammonite
      elmPackages.elm
      elmPackages.elm-language-server
      elmPackages.elm-format
    ]
    ++ [
      # github-desktop
      qbittorrent
      gltron
      libreoffice
      discord
      vlc
      firefox
      brave
      vscode
      evince
      pkgs-old.zoom-us
      obs-studio
      slack
      telegram-desktop
      dbeaver-bin
      pinta
      zen
      nixvim
    ];

  programs.home-manager = {
    enable = true;
  };

  programs.kitty = {
    enable = false;
    themeFile = "Argonaut";
    keybindings = {
      "kitty_mod+enter" = "launch --cwd=current --location=vsplit --bias=30";
    };
    settings.confirm_os_window_close = 0;
  };

  programs.alacritty = {
    enable = true;
    settings.cursor.style.shape = "block";
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 20;
  };
  #
  # gtk = {
  #   enable = true;
  #   theme = {
  #     package = pkgs.flat-remix-gtk;
  #     name = "Flat-Remix-GTK-Grey-Darkest";
  #   };
  #
  #   iconTheme = {
  #     package = pkgs.adwaita-icon-theme;
  #     name = "Adwaita";
  #   };
  # };
  #

  services.playerctld.enable = true;

  programs.waybar = {
    enable = false;
    settings = waybar-config.settings;
    style = waybar-config.style;
  };

  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = 300;
        height = 300;
        offset = "30x50";
        origin = "top-right";
        transparency = 90;
      };

      urgency_normal = {
        timeout = 10;
      };
    };
  };

  # services.hyprpaper = {
  #   enable = true;
  #   settings = {
  #     ipc = "off";
  #     splash = false;
  #     splash_offset = 2.0;
  #
  #     preload = [ "~/Pictures/thinknix-d.jpg" ];
  #
  #     wallpaper = [ ",~/Pictures/thinknix-d.jpg" ];
  #   };
  # };

  wayland.windowManager.hyprland = {
    enable = false;
    settings = hyprland-config.settings;
    extraConfig = hyprland-config.extraConfig;
    sourceFirst = true;
    systemd.variables = [ "--all" ];
  };

  programs.niri.settings = niri-config.settings;

  programs.hyprlock = {
    enable = true;
    extraConfig = hyprlock-config;
  };

  services.hypridle = {
    enable = false;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        lock_cmd = "hyprlock";
        before_sleep_cmd = "loginctl lock-session";
      };
      listener = [
        {
          timeout = 420;
          on-timeout = "hyprlock";
        }
        {
          timeout = 300;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 600;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };

  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 300;
        command = "${pkgs.hyprlock}/bin/hyprlock";
      }
      {
        timeout = 600;
        command = "systemctl suspend";
      }
      {
        timeout = 900;
        command = "systemctl hibernate";
      }
    ];
    events = {
      before-sleep = "${pkgs.hyprlock}/bin/hyprlock";
    };
  };

  programs.rofi = {
    enable = true;
    plugins = [
      pkgs.rofi-calc
      pkgs.rofi-power-menu
    ];
    extraConfig = {
      display-drun = "Applications";
      modi = "run,calc,power-menu:${pkgs.rofi-power-menu}/bin/rofi-power-menu,drun,filebrowser";
    };
    theme = "gruvbox-dark-hard";
  };

  programs.helix = helix-config.settings;

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  programs.bash = {
    enable = true;
    sessionVariables = {
      ANDROID_HOME = "~/Android/Sdk/";
    };
    shellAliases = {
      apply-home-manager-config = "cd ~/.dotfiles && home-manager switch --impure --flake .#rkc";
    };
  };

  programs.nixvim = nixvim-config.settings;

  programs.yazi = {
    enable = true;
    plugins = {
      inherit (pkgs.yaziPlugins) full-border;
    };
    initLua = ''
      require("full-border"):setup()
    '';
    flavors = {
      inherit (pkgs.yaziPlugins) nord;
    };
    theme = {
      flavor = {
        dark = "nord";
        light = "nord";
      };
    };
  };

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    image = wallpaper;
    targets = {
      rofi.enable = false;
    };
  };

  home.stateVersion = "26.05";
  nixpkgs.config.allowUnfree = true;

}
