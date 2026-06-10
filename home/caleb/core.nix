{ ... }:

{
  home.username = "caleb";
  home.homeDirectory = "/home/caleb";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  # TODO: migrate this once the Home Manager Hyprland lua module is stable.
  home.file.".config/hypr/hyprland.lua".source = ../../config/hypr/hyprland.lua;
}
