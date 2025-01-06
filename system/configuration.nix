{
  config,
  pkgs,
  inputs,
  ...
}:
let
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
  hyprland-session = "${pkgs.hyprland}/share/wayland-sessions";
  agenix = inputs.agenix;
in
{
  imports = [
    # Include the results of the hardware scan.
    /etc/nixos/hardware-configuration.nix
    inputs.agenix.nixosModules.default
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.enableRedistributableFirmware = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  #  time.timeZone = "Asia/Kolkata";
  time.timeZone = "America/New_York";
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
        command = "${tuigreet} --time --remember --remember-session --sessions ${hyprland-session}";
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

  services.printing.enable = true;

  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.pulseaudio.enable = false;
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
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    config.common.default = "*";
  };

  services.libinput = {
    enable = true;
  };

  fonts.packages = with pkgs; [ meslo-lgs-nf ];

  users.users.rkc = {
    isNormalUser = true;
    description = "Rishikesh Kumar";
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
    ];
    packages = with pkgs; [ ];
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.logind.extraConfig = ''
    IdleActionSec = 300;
    IdleAction = lock;
    powerKey = "ignore";
  '';

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
  };

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "mydatabase" ];
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust
    '';
  };

  services.clickhouse.enable = true;

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  system.stateVersion = "24.11";
}
