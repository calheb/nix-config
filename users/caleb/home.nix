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
    goxlr-utility
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
  home.file.".config/alacritty".source = ./config/alacritty;
  home.file.".config/ghostty".source = ./config/ghostty;
}

