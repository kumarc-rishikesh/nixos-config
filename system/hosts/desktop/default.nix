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

  swapDevices = [ { device = "/dev/disk/by-label/swap"; } ];

  base.hibernation = {
    enable = true;
    device = "/dev/disk/by-label/swap";
    hibernateAfterSleepDelay = "30m";
  };

  # AMD GPU — desktop only
  services.ollama.package = pkgs.ollama-rocm;
}
