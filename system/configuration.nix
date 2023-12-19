{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  networking.hostName = "nixos"; # Define your hostname.

  networking.networkmanager.enable = true;

#  time.timeZone = "Asia/Kolkata";
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_CTYPE="en_US.UTF-8";
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

  services.xserver={
    enable = true;
    layout = "us";
    xkbVariant = "";
    displayManager.defaultSession = "none+xmonad";
#    displayManager.defaultSession = "plasma";
#    displayManager.sddm.enable = true;
#    desktopManager.plasma5.enable = true;
    libinput = {
        enable = true;
        touchpad.naturalScrolling = true;
        };
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      };
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
      WIFI_PWR_ON_BAT = "on";
#      WOL_DISABLE = "Y";
      SOUND_POWER_SAVE_ON_AC = 0;
      SOUND_POWER_SAVE_ON_BAT = 1;
#      BAY_POWEROFF_ON_AC = 0;
#      BAY_POWEROFF_ON_BAT = 0;
#      BAY_DEVICE = "sr0";
      RUNTIME_PM_ON_AC = "on";
      RUNTIME_PM_ON_BAT = "auto";
#      USB_AUTOSUSPEND = 1;
#      USB_BLACKLIST_BTUSB = 0;
#      USB_BLACKLIST_PHONE = 0;
#      USB_BLACKLIST_WWAN = 1;
      RESTORE_DEVICE_STATE_ON_STARTUP = 1;
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 85;
#      DEVICES_TO_DISABLE_ON_LAN_CONNECT = "wifi wwan";
#      DEVICES_TO_DISABLE_ON_WIFI_CONNECT = "wwan";
#      DEVICES_TO_DISABLE_ON_WWAN_CONNECT = "wifi";
#      DEVICES_TO_ENABLE_ON_LAN_DISCONNECT = "wifi wwan";
#      DEVICES_TO_ENABLE_ON_WIFI_DISCONNECT = "";
#      DEVICES_TO_ENABLE_ON_WWAN_DISCONNECT = "";
      };
  };
 
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;

  services.printing.enable = true;

 sound.enable = true;
 hardware.bluetooth.enable = true;
 hardware.pulseaudio.enable = false;
 security.rtkit.enable = true;
 services.pipewire = {
   enable = true;
   alsa.enable = true;
   alsa.support32Bit = true;
   pulse.enable = false;
 };

  # hardware.bluetooth.enable = true;
  # hardware.bluetooth.powerOnBoot = true;
  # services.blueman.enable = true;
  # hardware.pulseaudio = {
  #   enable = true;
  #   package = pkgs.pulseaudioFull;
  #   configFile = pkgs.writeText "default.pa" ''
  #     load-module module-bluetooth-policy
  #     load-module module-bluetooth-discover
  #     ## module fails to load with 
  #     ##   module-bluez5-device.c: Failed to get device path from module arguments
  #     ##   module.c: Failed to load module "module-bluez5-device" (argument: ""): initialization failed.
  #     # load-module module-bluez5-device
  #     # load-module module-bluez5-discover
  #   '';
  #   extraConfig = "
  #     load-module module-switch-on-connect
  #     ";

  # };
  # hardware.bluetooth.settings = {
  #   General = {
  #     Enable = "Source,Sink,Media,Socket";
  #   };
  # };


  users.users.rkc = {
    isNormalUser = true;
    description = "Rishikesh Kumar";
    extraGroups = [ "networkmanager" "wheel" "audio" ];
    packages = with pkgs; [];
  };

  services.logind.extraConfig = ''
      IdleActionSec = 300;
      IdleAction = lock;
  '';

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    home-manager
    git
  ];

  system.stateVersion = "23.05"; 
  services.picom.enable = true;


  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
    experimental-features = nix-command flakes
    '';
  };


  boot.binfmt.emulatedSystems =
    ["aarch64-linux"];
}
