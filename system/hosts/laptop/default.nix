{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../common.nix
  ];

  networking.hostName = "laptop";

  services.fprintd.enable = true;

  security.pam.services.greetd.fprintAuth = true;
  security.pam.services.login.fprintAuth = false;
  security.pam.services.su.fprintAuth = false;
  security.pam.services.sudo.fprintAuth = false;

  swapDevices = [ { device = "/dev/nvme0n1p3"; } ];
}
