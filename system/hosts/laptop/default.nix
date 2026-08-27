{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../common.nix
    ../../hibernation.nix
  ];

  networking.hostName = "laptop";

  # Fingerprint reader (see note below)
  services.fprintd.enable = true;
  security.pam.services.hyprlock.fprintAuth = true;
  security.pam.services.login.fprintAuth = true;
  security.pam.services.sudo.fprintAuth = true;

  # Swap/hibernation: fill in once you know the laptop's swap device.
  # If you set up a labeled swap partition the same way, this is identical:
  # swapDevices = [ { device = "/dev/disk/by-label/swap"; } ];
  # base.hibernation = {
  #   enable = true;
  #   device = "/dev/disk/by-label/swap";
  #   hibernateAfterSleepDelay = "30m";
  # };
}
