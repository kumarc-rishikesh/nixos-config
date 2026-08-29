{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../common.nix
    ../../hibernation.nix
  ];

  networking.hostName = "laptop";

  # Fingerprint reader
  services.fprintd.enable = true;
  security.pam.services.login.fprintAuth = true;
  security.pam.services.sudo.fprintAuth = true;

  swapDevices = [ { device = "/dev/nvme0n1p3"; } ];
  base.hibernation = {
    enable = true;
    device = "/dev/nvme0n1p3";
    hibernateAfterSleepDelay = "30m";
  };
}
