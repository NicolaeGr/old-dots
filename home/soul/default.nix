{
  configLib,
  ...
}:
{
  imports = map configLib.relativeToRoot [ "home/_common" ];

  home.stateVersion = "26.05";

  home.file = { };
}
