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
  home.packages =
    with pkgs;
    [
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
      cabal2nix
      haskellPackages.zlib
      stack
      ghc
      miller
      elixir_1_15
      elixir-ls
      sbt
      metals
      scalafmt
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
    ];

  programs.home-manager = {
    enable = true;
  };

  programs.kitty = {
    enable = true;
    theme = "Argonaut";
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

      wallpaper = [ "eDP-1,~/Pictures/thinknix-d.jpg" ];
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

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
    config.common.default = "*";
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
        line-number = "relative";
        lsp.display-messages = true;
      };
    };
    languages = {
      language = [
        {
          name = "haskell";
          auto-format = true;
          formatter = {
            command = "fourmolu";
          };
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

  home.stateVersion = "24.05";
  nixpkgs.config.allowUnfree = true;

}
