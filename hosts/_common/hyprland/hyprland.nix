{
  pkgs,
  ...
}:
{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  services.displayManager = {
    sessionPackages = with pkgs; [ hyprland ];
  };

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;
  programs.ssh.startAgent = false;

  programs.seahorse.enable = true;

  environment.systemPackages = with pkgs; [
    wl-clipboard
  ];

  hardware.i2c.enable = true;
}
