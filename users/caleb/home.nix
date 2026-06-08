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
    eza

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
      gtk-single-instance = false;

      # font-family = "Fira Code Nerd Font";
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
    userName = "Caleb Hebert";
    userEmail = "caleb@linux.com";
    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "nvim";
    };
  };

  home.file.".config/nvim".source = ./config/nvim;
  home.file.".config/hypr".source = ./config/hypr;
}

