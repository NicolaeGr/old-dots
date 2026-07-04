{
  inputs,
  ...
}:
{
  imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];

  services.flatpak = {
    enable = true;
    uninstallUnmanaged = true;
    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };

    remotes = [
      {
        name = "flathub";
        location = "https://flathub.org/repo/flathub.flatpakrepo";
      }
      {
        name = "flathub-beta";
        location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
      }
      {
        name = "gnome-nightly";
        location = "https://nightly.gnome.org/gnome-nightly.flatpakrepo";
      }
    ];

    overrides = {
      global = {
        Context = {
          sockets = [
            "wayland"
            "!x11"
            "!fallback-x11"
          ];
        };
      };
    };
  };
}
