{ ... }:

{
  programs.ghostty = {
    enable = true;
    settings = {
      theme = "Catppuccin Mocha";
      #theme = "Gruber Darker";
      gtk-single-instance = false;
      # font-family = "Fira Code Nerd Font";
      font-family = "Iosevka Nerd Font";
      font-size = 16.0;
    };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = 14.0;
        normal = {
          family = "FiraCode Nerd Font Mono";
          style = "Regular";
        };
        bold = {
          family = "FiraCode Nerd Font Mono";
          style = "Bold";
        };
        italic = {
          family = "FiraCode Nerd Font Mono";
          style = "Italic";
        };
      };
    };
  };
}
