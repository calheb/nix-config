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

  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      lua.disabled = true;
      custom.nix = {
        command = "echo -n ''";
        when = "true";
        format = "[$symbol]($style) ";
        symbol = " ";
        style = "bold blue";
      };
    };
  };
}
