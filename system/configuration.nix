{
  config,
  pkgs,
  inputs,
  ...
}:
let
  tuigreet = "${pkgs.tuigreet}/bin/tuigreet";
  wayland-session = "${pkgs.niri}/share/wayland-sessions";
  agenix = inputs.agenix;
  wallpaperPkg = inputs.thinknix-wallpaper.packages.${pkgs.system}.default;
  wallpaper = pkgs.runCommand "thinknix-d.png" { buildInputs = [ pkgs.resvg ]; } ''
    resvg ${wallpaperPkg}/share/backgrounds/gnome/thinknix-d.svg $out
  '';
in
{
  imports = [
    # Include the results of the hardware scan.
    /etc/nixos/hardware-configuration.nix
    inputs.agenix.nixosModules.default
    ./hibernation.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.enableRedistributableFirmware = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager = {
    enable = true;
    wifi.powersave = true;
  };

  #  time.timeZone = "Asia/Kolkata";
  services.automatic-timezoned.enable = true;
  services.geoclue2.geoProviderUrl = "https://api.beacondb.net/v1/geolocate";
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_CTYPE = "en_US.UTF-8";
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
    enable = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${tuigreet} --time --remember --remember-session --sessions ${wayland-session}";
        user = "greeter";
      };
    };
  };

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal"; # Without this errors will spam on screen
    # Without these bootlogs will spam on screen
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

  environment.shells = with pkgs; [ bash ];

  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
  };

  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
  programs.bash.shellAliases = {
    apply-nixos-config = "cd ~/.dotfiles && sudo nixos-rebuild switch --flake .#nixos";
  };

  services.printing.enable = true;

  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  programs.hyprland = {
    enable = false;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  programs.niri.enable = true;

  # xdg.portal = {
  #   enable = true;
  #   extraPortals = [
  #     pkgs.xdg-desktop-portal-gtk
  #   ];
  #   config.common.default = "*";
  # };
  # services.libinput = {
  #   enable = true;
  # };
  #
  # fonts.packages = with pkgs; [ meslo-lgs-nf ];

  users.users.rkc = {
    isNormalUser = true;
    description = "Rishikesh Kumar";
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
      "kvm"
      "libvirtd"
    ];
    packages = with pkgs; [ ];
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  swapDevices = [ { device = "/dev/disk/by-label/swap"; } ];

  base.hibernation = {
    enable = true;
    device = "/dev/disk/by-label/swap";
    hibernateAfterSleepDelay = "30m";
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = [
    inputs.agenix.packages."x86_64-linux".default
    pkgs.home-manager
    pkgs.git
    pkgs.distrobox
  ];

  nix = {
    # package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings = {
      substituters = [ "https://noctalia.cachix.org" ];
      trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
    };
  };

  # Enable common container config files in /etc/containers
  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
    libvirtd.enable = true;
  };

  services = {
    postgresql = {
      enable = false;
      ensureDatabases = [ "mydatabase" ];
      authentication = pkgs.lib.mkOverride 10 ''
        #type database  DBuser  auth-method
        local all       all     trust
      '';
    };
    clickhouse = {
      enable = false;
    };
    ollama = {
      enable = true;
      package = pkgs.ollama-rocm;
    };
  };

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";

    image = wallpaper;

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.meslo-lg;
        name = "JetBrainsMono Nerd Font";
      };
      sansSerif = {
        package = pkgs.inter;
        name = "Inter";
      };
      sizes.terminal = 13;
    };
  };

  system.stateVersion = "26.05";
}
