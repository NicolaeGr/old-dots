{
  pkgs,
  config,
  configLib,
  ...
}:
{
  users.users = {
    soul = {
      isNormalUser = true;
      home = "/home/soul";
      shell = pkgs.zsh;

      initialPassword = "bottle";

      extraGroups = configLib.ifUserGroupExists (configLib.defaultUserGroups ++ [ "wheel" ]) config;
    };
  };

  home-manager.users.soul.imports = [
    {
      home = {
        username = "soul";
        homeDirectory = "/home/soul";
      };
    }
    (configLib.relativeToRoot "home/soul/default.nix")
  ];

}
