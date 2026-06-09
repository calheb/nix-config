{ config, pkgs, ... }:

{
  home.username = "caleb";
  home.homeDirectory = "/home/caleb";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    neovim
    git
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

    # LSPs
    lua-language-server
    clang-tools
    typescript-language-server
    vscode-langservers-extracted
    bash-language-server
    haskell-language-server
    pyright
    nixd
    omnisharp-roslyn

    # Formatters
    stylua
    prettier
    shfmt
    haskellPackages.fourmolu
    python3Packages.black
    nixpkgs-fmt
    csharpier
  ];

  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      preload = [
        "/home/caleb/Pictures/wallpapers/nix-wallpaper-dracula.png"
      ];
      wallpaper = [
        {
          monitor = "DP-1";
          path = "/home/caleb/Pictures/wallpapers/nix-wallpaper-dracula.png";
        }
        {
          monitor = "DP-2";
          path = "/home/caleb/Pictures/wallpapers/nix-wallpaper-dracula.png";
        }
      ];
    };
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      ls = "eza --icons";
      tree = "eza --tree";
      grep = "grep --color=auto";
      love = "love-git";
    };
    initExtra = ''
      export TERMINAL=ghostty
    '';
  };

  programs.starship.enable = true;

  programs.ghostty = {
    enable = true;
    settings = {
      theme = "Catppuccin Mocha";
      #theme = "Gruber Darker";
      gtk-single-instance = false;

      # font-family = "Fira Code Nerd Font";
      font-family = "Iosevka Nerd Font";
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

  programs.git = {
    enable = true;
    settings = {
      user.name = "Caleb Hebert";
      user.email = "caleb@linux.com";
      init.defaultBranch = "main";
      core.editor = "nvim";
    };
  };

  home.file.".config/nvim".source = ./config/nvim;
  home.file.".config/hypr/hyprland.lua".source = ./config/hypr/hyprland.lua;
}

