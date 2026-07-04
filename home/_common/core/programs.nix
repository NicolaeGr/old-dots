{ pkgs, ... }: {
  home.packages = with pkgs; [
    firefox
    vscodium
    obsidian
    waybar
    rofi
    dunst
    libnotify
    awww
    kitty
    seahorse
  ];
}
