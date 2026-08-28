{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../common.nix
  ];

  networking.hostName = "laptop";

  # Fingerprint reader (see note below)
  services.fprintd.enable = true;
  security.pam.services.hyprlock.fprintAuth = true;
  security.pam.services.login.fprintAuth = true;
  security.pam.services.sudo.fprintAuth = true;

  swapDevices = [ { device = "/dev/nvme0n1p3/swap"; } ];
  hibernation = {
    enable = true;
    device = "/dev/nvme0n1p3/swap";
    hibernateAfterSleepDelay = "30m";
  };
}
