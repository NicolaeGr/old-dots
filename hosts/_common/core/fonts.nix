{ pkgs, ... }: {
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji

    fira-code
    fira-code-symbols

    nerd-fonts.jetbrains-mono
  ];
}
