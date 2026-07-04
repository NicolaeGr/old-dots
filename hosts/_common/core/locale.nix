{ lib, ... }:
{
  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";
  time.timeZone = lib.mkDefault "Europe/Chisinau";

  console = {
    enable = true;
    keyMap = "us";
  };
}
