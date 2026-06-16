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
    microfetch
    mullvad
    qbittorrent
    xournalpp
    libreoffice
    spotify
    unzip
    eza # ls replacement
    obs-studio
    vlc
    gcc
    valgrind
    gnumake
    playerctl
    swaylock
    wlogout
    pavucontrol
    gnome-terminal
    bear
  ];
}
