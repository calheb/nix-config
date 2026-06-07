{ config, pkgs, ... }:

{
  home.username = "caleb";
  home.homeDirectory = "/home/caleb";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  home.file.".config/nvim".source = ./config/nvim;
  home.file.".config/hypr".source = ./config/hypr;
  home.file.".config/alacritty".source = ./config/alacritty;
  home.file.".config/ghostty".source = ./config/ghostty;
}
