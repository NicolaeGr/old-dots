{
  configLib,
  hostName ? "soul",
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ]
  ++ (map configLib.relativeToRoot [
    "hosts/_common"
  ]);

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = hostName;
  networking.networkmanager.enable = true;

  networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
}
