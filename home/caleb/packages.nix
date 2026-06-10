{ pkgs, ... }:

{
  home.packages = with pkgs; [
    keepassxc
    signal-desktop
    discord
    vscode
    godot
    nodejs
    gimp
    fastfetch
    mullvad
    qbittorrent
    xournalpp
    libreoffice
    spotify
    unzip
    eza # ls replacement
    obs-studio
    vlc
  ];
}
