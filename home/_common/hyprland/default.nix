{
  lib,
  pkgs,
  config,
  configLib,
  ...
}:
let
  hyprlandConfigPath = configLib.outOfStorePath ./config;
  hasOutOfStoreConfig = builtins.pathExists hyprlandConfigPath;
in
{
  imports = (configLib.scanPaths ./.);

  home.packages = with pkgs; [
    libnotify
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";

    systemd = {
      enable = false;
      variables = [ "--all" ];
    };

    settings = { };

    extraConfig = ''
      hl.exec_cmd("source = $HOME/.config/hypr/conf.d/init.lua")
    '';
  };

  home.file.".config/hypr/conf.d" = lib.mkIf hasOutOfStoreConfig {
    source = config.lib.file.mkOutOfStoreSymlink hyprlandConfigPath;
  };
}
