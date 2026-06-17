# https://blog.tiserbox.com/posts/2025-03-10-enable-hibernation-on-nix-os.html
{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.base;
in
{
  options.base = {
    hibernation = lib.mkOption {
      description = ''
        Options to configuration hibernation.
      '';
      type = lib.types.submodule {
        options = {
          enable = lib.mkEnableOption "hibernation";

          device = lib.mkOption {
            type = lib.types.str;
            description = ''
              Device used to store hibernation
              information. Use lsblk to find it.
            '';
            example = "/dev/disk/by-label/swap";
          };

          hibernateAfterSleepDelay = lib.mkOption {
            type = lib.types.str;
            description = ''
              Hibernate after sleeping for this long.
            '';
            default = "2h";
          };
        };
      };
    };
  };

  config = {
    powerManagement.enable = true;

    # Specifies where the hibernation info will be stored.
    boot.kernelParams = [
      "resume=${cfg.hibernation.device}"
    ];

    # Allow hibernation
    security.protectKernelImage = !cfg.hibernation.enable;

    # Enable hibernation in menus
    environment.etc = lib.mkIf cfg.hibernation.enable {
      "/polkit-1/localauthority/50-local.d/com.ubuntu.enable-hibernate.pkla".text = ''
        [Re-enable hibernate by default in upower]
        Identity=unix-user:*
        Action=org.freedesktop.upower.hibernate
        ResultActive=yes

        [Re-enable hibernate by default in logind]
        Identity=unix-user:*
        Action=org.freedesktop.login1.hibernate;org.freedesktop.login1.handle-hibernate-key;org.freedesktop.login1;org.freedesktop.login1.hibernate-multiple-sessions;org.freedesktop.login1.hibernate-ignore-inhibit
        ResultActive=yes
      '';
    };

    services.logind = lib.mkIf cfg.hibernation.enable {
      settings.Login = {
        HandleLidSwitch = "suspend-then-hibernate";
        HandlePowerKey = "suspend-then-hibernate";
        IdleAction = "suspend-then-hibernate";
        IdleActionSec = "2m";
      };
    };

    #
    systemd.sleep.settings = lib.mkIf cfg.hibernation.enable {
      Sleep.HibernateDelaySec = cfg.hibernation.hibernateAfterSleepDelay;
    };
  };
}
