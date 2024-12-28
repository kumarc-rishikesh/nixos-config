{ pkgs, ... }:
let
  alacritty-config = import ./alacritty-config.nix;
  hyprland-config = import ./hyprland-config.nix;
  waybar-config = import ./waybar-conf.nix;
  hyprlock-config = builtins.readFile ./hyprlock.conf;
in
{
  home.username = "rkc";
  home.homeDirectory = "/home/rkc";
  nixpkgs.overlays = [
    (final: prev: {
      spark = prev.spark.overrideAttrs (oldAttrs: {
        postInstall = ''
          mkdir -p $out/share/doc/spark/
          mv $out/LICENSE $out/NOTICE $out/share/doc/spark/
        '';
      });

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
      vim
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
      jq
      localstack
    ]
    ++ [
      nodejs
      esbuild
      yarn
      nodePackages.typescript-language-server
      nodePackages.npm
      rustc
      rust-analyzer
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
      elixir_1_15
      elixir-ls
      scala
      jdk11
      spark
      sbt
      metals
      scala-cli
      scalafmt
      ammonite
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
      zoom-us
      obs-studio
      okular
      slack
      jetbrains.idea-community
      telegram-desktop
      dbeaver-bin
    ];

  programs.home-manager = {
    enable = true;
  };

  programs.kitty = {
    enable = true;
    themeFile = "Argonaut";
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

      preload = [ "./thinknix-d.jpg" ];

      wallpaper = [ "eDP-1,./thinknix-d.jpg" ];
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

  programs.neovim = {
    enable = true;
    coc.enable = false;
    plugins = with pkgs.vimPlugins; [
      vim-sensible
      {
        plugin = nerdtree;
        config = "let g:NERDTreeMinimalUI = 1";
      }
      purescript-vim
      dracula-nvim
      haskell-vim
      nvchad
    ];
    viAlias = true;
    extraConfig = ''
      set clipboard+=unnamedplus
      syntax enable
    '';
  };

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    plugins = [
      (pkgs.rofi-calc.override { rofi-unwrapped = pkgs.rofi-wayland-unwrapped; })
      pkgs.rofi-power-menu
    ];
    extraConfig = {
      display-drun = "Applications";
      modi = "run,calc,power-menu:${pkgs.rofi-power-menu}/bin/rofi-power-menu,drun,filebrowser";
    };
    theme = "DarkBlue";
  };

  programs.helix = {
    enable = true;
    settings = {
      theme = "base16_terminal";
      editor = {
        lsp.display-messages = true;
      };
      keys.normal = {
        space.r = ":reset-diff-change";
        C-e = "goto_line_end";
        C-a = "goto_line_start";
      };
    };
    languages = {
      language-server.haskell-language-server = {
        config.formattingProvider = "fourmolu";
      };
      language = [
        {
          name = "haskell";
          auto-format = true;
        }
        {
          name = "nix";
          auto-format = true;
          formatter = {
            command = "nixfmt";
          };
        }
        {
          name = "elixir";
          auto-format = true;
          formatter = {
            command = "mix format";
          };
        }
        {
          name = "scala";
          auto-format = true;
          formatter = {
            command = "scalafmt";
          };
        }
      ];
    };
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  programs.bash = {
    enable = true;
  };

  home.stateVersion = "24.11";
  nixpkgs.config.allowUnfree = true;

}
