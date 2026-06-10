{ ... }:

{
  programs.bash = {
    enable = true;
    shellAliases = {
      ls = "eza --icons";
      tree = "eza --tree";
      grep = "grep --color=auto";
    };
    initExtra = ''
      export TERMINAL=ghostty
    '';
  };

  programs.starship.enable = true;
}
