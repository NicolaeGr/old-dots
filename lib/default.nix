{
  lib,
  flakeRoot ? null,
  ...
}:
{
  relativeToRoot = path: ./. + "/../${path}";

  outOfStorePath =
    storePath:
    let
      effectiveFlakeRoot = if flakeRoot != null then flakeRoot else builtins.getEnv "FLAKE_ROOT";
      storePathStr = builtins.toString storePath;
      relPath = builtins.head (builtins.match ".*/[^/]+-source/(.*)" storePathStr);
      checkoutPath =
        if effectiveFlakeRoot != "" && relPath != null then "${effectiveFlakeRoot}/${relPath}" else null;
    in
    if checkoutPath != null then
      checkoutPath
    else
      builtins.trace "⚠️ FLAKE_ROOT not set or path mismatch; using in-store path for ${storePathStr}" (
        builtins.toString storePath
      );

  ifUserGroupExists =
    groups: config: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;

  defaultUserGroups = [
    "audio"
    "video"
    "input"
    "users"
    "power"
    "render"
    "docker"
    "libvirt"
    "storage"
    "libvirtd"
    "adbusers"
    "vboxusers"
    "sambashare"
    "networkmanager"
  ];

  scanPaths =
    path:
    builtins.map (f: (path + "/${f}")) (
      builtins.attrNames (
        lib.attrsets.filterAttrs (
          path: _type:
          (_type == "directory") || ((path != "default.nix") && (lib.strings.hasSuffix ".nix" path))
        ) (builtins.readDir path)
      )
    );
}
