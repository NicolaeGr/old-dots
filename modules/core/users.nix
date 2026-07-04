{
  pkgs,
  system,
  ...
}:
{

  users.users = {
    soul = {
      isNormalUser = true;
      home = "/home/soul";
      shell = pkgs.zsh;

      extraGroups = [
        "wheel"
        "networkmanager"
        "audio"
        "video"
        "input"
        "storage"
        "users"
        "power"
        "libvirt"
        "docker"
      ];
    };
  };

  home-manager = {
    extraSpecialArgs = {
      inherit system;
    };

    users = {
      soul = {
        imports = [
          ./../../home/soul
        ];

        home.stateVersion = "26.05";

        programs.home-manager.enable = true;
      };
    };
  };
}
