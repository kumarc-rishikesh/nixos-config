{
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../common.nix
    ../../hibernation.nix
  ];

  networking.hostName = "nixos";

  swapDevices = [ { device = "/dev/nvme0n1p4"; } ];

  base.hibernation = {
    enable = true;
    device = "/dev/nvme0n1p4";
    hibernateAfterSleepDelay = "30m";
  };

  # AMD GPU — desktop only
  services.ollama.package = pkgs.ollama-rocm;
}
