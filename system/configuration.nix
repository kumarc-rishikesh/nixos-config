{ config, pkgs, ... }:

{
  imports =
    [
    ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "nixos"; # Define your hostname.

  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Kolkata";

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

  services.xserver.enable = true;

  services.xserver.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
    };

  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;

  services.printing.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = false;
  };

  users.users.rkc = {
    isNormalUser = true;
    description = "Rishikesh Kumar";
    extraGroups = [ "networkmanager" "wheel" "audio" ];
    packages = with pkgs; [];
};

  services.xserver={
    displayManager.defaultSession = "none+xmonad";
#    displayManager.sddm.enable = true;
#    desktopManager.plasma5.enable = true;
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      };
    };

  services.logind.extraConfig = ''
      IdleActionSec = 300;
      IdleAction = lock;
  '';

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    home-manager
  ];

  system.stateVersion = "22.11"; 
  boot.kernelPackages = pkgs.linuxPackages_6_1;
  hardware.bluetooth.enable = true;
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
