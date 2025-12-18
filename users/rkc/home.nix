{
  pkgs,
  pkgs-unstable,
  pkgs-old,
  inputs,
  system,
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
      ref = "nixos-25.11";
    }
  );
  zen = inputs.zen-browser.packages.${system}.default;
in
{
  imports = [
    nixvim.homeModules.nixvim
  ];
  home.username = "rkc";
  home.homeDirectory = "/home/rkc";
  nixpkgs.overlays = [
    (final: prev: {
      # spark = prev.spark.overrideAttrs (oldAttrs: {
      #   postInstall = ''
      #     mkdir -p $out/share/doc/spark/
      #     mv $out/LICENSE $out/NOTICE $out/share/doc/spark/
      #   '';
      # });

      scala = prev.scala.overrideAttrs (oldAttrs: {
        postInstall = ''
          mkdir -p $out/share/doc/scala/
          mv $out/LICENSE $out/NOTICE $out/share/doc/scala/
        '';
      });
    })
  ];
  home.packages =
    with pkgs;
    [
      busybox
      bluetuith
      alacritty
      feh
      alsa-utils
      ranger
      neofetch
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
      hyprshot
      hyprpaper
      distrobox
      cheese
      jq
      localstack
    ]
    ++ [
      nodejs
      esbuild
      yarn
      nodePackages.typescript-language-server
      rustc
      rust-analyzer
      rustfmt
      cargo
      python311
      python311.pkgs.pip
      poetry
      python311Packages.python-lsp-server
      nil
      nixfmt-rfc-style
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
      scala_2_13
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
    ];

  programs.home-manager = {
    enable = true;
  };

  programs.kitty = {
    enable = true;
    themeFile = "Argonaut";
    keybindings = {
      "kitty_mod+enter" = "launch --cwd=current --location=vsplit --bias=30";
    };
    settings.confirm_os_window_close = 0;
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 20;
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Grey-Darkest";
    };

    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
  };

  services.playerctld.enable = true;

  programs.waybar = {
    enable = true;
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
        frame_color = "#000000";
        font = "Droid Sans 9";
      };

      urgency_normal = {
        background = "#9ea0a3";
        foreground = "#000000";
        timeout = 10;
      };
    };
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "off";
      splash = false;
      splash_offset = 2.0;

      preload = [ "~/Pictures/thinknix-d.jpg" ];

      wallpaper = [ ",~/Pictures/thinknix-d.jpg" ];
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = hyprland-config.settings;
    extraConfig = hyprland-config.extraConfig;
    sourceFirst = true;
    systemd.variables = [ "--all" ];
  };

  programs.hyprlock = {
    enable = true;
    extraConfig = hyprlock-config;
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        lock_cmd = "hyprlock";
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
      ];
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
    theme = "DarkBlue";
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
  };

  programs.nixvim = nixvim-config.settings;

  home.stateVersion = "24.11";
  nixpkgs.config.allowUnfree = true;

}
