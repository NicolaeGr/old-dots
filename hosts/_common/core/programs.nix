{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    nixpkgs-fmt

    # Editors
    vim
    neovim

    # Utils
    fastfetch
    wget
    curl
    git
    man
    ripgrep
    jq
    eza
    fzf

    # Archive
    zip
    xz
    unzip
    p7zip

    # Programming
    gcc
    rustup
    glow
    btop
    iotop
    iftop
  ];
}
