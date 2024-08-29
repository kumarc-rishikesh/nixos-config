{
  config,
  pkgs,
  inputs,
  ...
}:
let
  network_connections = import /home/rkc/.config/networks.nix;
  tokyo-night-sddm = pkgs.libsForQt5.callPackage ./tokyo-night-sddm/default.nix { };
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

  networking.hostName = "nixos"; # Define your hostname.

  networking.wireless = {
    enable = true;
    userControlled.enable = true;
    networks = network_connections;
  };

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

  services.displayManager.sddm = {
    enable = true;
    theme = "tokyo-night-sddm";
  };

  environment.shells = with pkgs; [ bash ];

  services.tlp = {
    enable = true;
    settings = {
      TLP_DEFAULT_MODE = "AC";
      TLP_PERSISTENT_DEFAULT = 0;
      DISK_IDLE_SECS_ON_AC = 0;
      DISK_IDLE_SECS_ON_BAT = 2;
      MAX_LOST_WORK_SECS_ON_AC = 15;
      MAX_LOST_WORK_SECS_ON_BAT = 60;
      CPU_HWP_ON_AC = "performance";
      CPU_HWP_ON_BAT = "balance_power";
      SCHED_POWERSAVE_ON_AC = 0;
      SCHED_POWERSAVE_ON_BAT = 1;
      NMI_WATCHDOG = 0;
      ENERGY_PERF_POLICY_ON_AC = "performance";
      ENERGY_PERF_POLICY_ON_BAT = "powersave";
      DISK_APM_LEVEL_ON_AC = "254 254";
      DISK_APM_LEVEL_ON_BAT = "128 128";
      SATA_LINKPWR_ON_AC = "max_performance";
      SATA_LINKPWR_ON_BAT = "min_power";
      PCIE_ASPM_ON_AC = "performance";
      PCIE_ASPM_ON_BAT = "powersave";
      RADEON_POWER_PROFILE_ON_AC = "high";
      SOUND_POWER_SAVE_CONTROLLER = "Y";
      RADEON_POWER_PROFILE_ON_BAT = "low";
      RADEON_DPM_PERF_LEVEL_ON_AC = "auto";
      RADEON_DPM_PERF_LEVEL_ON_BAT = "auto";
      WIFI_PWR_ON_AC = "on";
      # WIFI_PWR_ON_AC = "on";
      SOUND_POWER_SAVE_ON_AC = 0;
      SOUND_POWER_SAVE_ON_BAT = 1;
      RUNTIME_PM_ON_AC = "on";
      RUNTIME_PM_ON_BAT = "auto";
      RESTORE_DEVICE_STATE_ON_STARTUP = 1;
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 85;
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

  programs.hyprland.enable = true;

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
    tokyo-night-sddm
  ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  virtualisation.docker = {
    enable = true;
    rootless.enable = true;
  };

  services.postgresql = {
    enable = true;
  };

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  system.stateVersion = "24.05";
}
