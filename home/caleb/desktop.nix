{ ... }:

let
  wallpaper = "/home/caleb/Pictures/wallpapers/nix-wallpaper-dracula.png";
in
{
  services.hyprpaper = {
    enable = true;

    settings = {
      ipc = true;
      splash = false;

      preload = [
        wallpaper
      ];

      wallpaper = [
        {
          monitor = "";
          path = wallpaper;
          fit_mode = "cover";
        }
      ];
    };
  };
}
