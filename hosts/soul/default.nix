{
  inputs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "soul";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Chisinau";

  networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
}
