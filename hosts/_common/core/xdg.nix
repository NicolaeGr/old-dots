{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    xdg-utils
    xdg-user-dirs
  ];
}
