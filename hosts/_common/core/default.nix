{
  lib,
  pkgs,
  inputs,
  outputs,
  configLib,
  ...
}:
{
  imports = lib.flatten [
    (configLib.scanPaths ./.)
    inputs.home-manager.nixosModules.home-manager
  ];

  config = {
    services.fwupd.enable = true;
    services.dbus.enable = true;

    boot.loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = lib.mkDefault 10;
      };
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };

    boot.initrd = {
      systemd.enable = true;
    };

    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 14d --keep 3";
    };

    systemd.services.nh-clean-on-high-disk-usage = {
      description = "Run nh clean when root disk usage reaches 80%";
      serviceConfig = {
        Type = "oneshot";
      };
      script = ''
        set -eu

        usage="$(${pkgs.coreutils}/bin/df -P / | ${pkgs.coreutils}/bin/tail -n 1 | ${pkgs.gawk}/bin/awk '{print $5}' | ${pkgs.gnused}/bin/sed 's/%//')"
        if [ "''${usage}" -ge 80 ]; then
          ${pkgs.nh}/bin/nh clean all --keep-since 14d --keep 3
        fi
      '';
    };

    systemd.timers.nh-clean-on-high-disk-usage = {
      description = "Check disk usage and trigger nh clean at 80%";
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnBootSec = "5m";
        OnUnitActiveSec = "30m";
        Unit = "nh-clean-on-high-disk-usage.service";
      };
    };

    nixpkgs = {
      overlays = builtins.attrValues outputs.overlays;
      config = {
        allowUnfree = true;
        # pnpm-10.29.2 is pinned for electron-based apps that haven't
        # migrated past the 10.29.3 breaking change. Remove once
        # nixpkgs drops the pnpm_10_29_2 variant.
        permittedInsecurePackages = [
          "pnpm-10.29.2"
        ];
      };

      hostPlatform = lib.mkDefault "x86_64-linux";
    };

    programs.mtr.enable = true;
    services.upower.enable = true;

    programs.gnupg.agent.enable = true;
    programs.ssh.extraConfig = ''
      AddKeysToAgent yes
    '';

    services.openssh = {
      enable = true;
      ports = [ 22 ];

      settings.PasswordAuthentication = false;
      settings.KbdInteractiveAuthentication = false;
      settings.PermitRootLogin = "no";
    };

    security.sudo.extraConfig = ''
      Defaults lecture = never # rollback results in sudo lectures after each reboot, it's somewhat useless anyway
      Defaults pwfeedback # password input feedback - makes typed password visible as asterisks
      # Keep SSH_AUTH_SOCK so that pam_ssh_agent_auth.so can do its magic.
      Defaults env_keep+=SSH_AUTH_SOCK
    '';

    hardware.enableRedistributableFirmware = true;

    system.stateVersion = "26.05";
  };
}
