{ nix-config, ... }:

{
  imports = [
    nix-config.inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    extraSpecialArgs = {
      inherit nix-config;
    };

    users.caleb.imports = [
      ../../home/caleb
    ];
  };
}
