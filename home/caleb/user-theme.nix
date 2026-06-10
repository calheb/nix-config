{ nix-config, ... }:

{
  imports = [
    nix-config.inputs.catppuccin.homeModules.catppuccin
  ];

  catppuccin = {
    enable = true;
    autoEnable = true;

    flavor = "mocha";
    accent = "mauve";
  };
}
