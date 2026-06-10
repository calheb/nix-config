{ nix-config, ... }:

{
  imports = [
    nix-config.inputs.catppuccin.nixosModules.catppuccin
  ];

  boot.plymouth.enable = true;

  catppuccin = {
    enable = true;
    autoEnable = true;
    flavor = "mocha";
    accent = "mauve";

    plymouth.enable = true;
    tty.enable = true;

    grub.enable = false;
    limine.enable = false;
    sddm.enable = false;
  };
}
