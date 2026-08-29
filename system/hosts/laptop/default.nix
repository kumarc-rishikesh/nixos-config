{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../common.nix
  ];

  networking.hostName = "laptop";

  services.fprintd.enable = true;

  security.pam.services.greetd.fprintAuth = false;
  security.pam.services.login.fprintAuth = false;
  security.pam.services.su.fprintAuth = false;
  security.pam.services.sudo.fprintAuth = false;

  # security.polkit.extraConfig = ''
  #   polkit.addRule(function(action, subject) {
  #     if (action.id.indexOf("net.reactivated.fprint.") === 0) {
  #       return polkit.Result.YES;
  #     }
  #   });
  # '';
  #
  swapDevices = [ { device = "/dev/nvme0n1p3"; } ];
}
